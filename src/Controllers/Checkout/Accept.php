<?php

namespace Controllers\Checkout;

use Controllers\PublicController;

class Accept extends PublicController
{

    private function formatDate(?string $isoDate): string
    {
        if (empty($isoDate)) {
            return "N/D";
        }
        $timestamp = strtotime($isoDate);
        if ($timestamp === false) {
            return $isoDate;
        }
        return date("d/m/Y h:i a", $timestamp);
    }

    private function formatAmount($value, string $currency): string
    {
        $numericValue = is_numeric($value) ? (float)$value : 0;
        return number_format($numericValue, 2) . " " . $currency;
    }
    public function run(): void
    {
        $dataview = array(
            "hasOrder" => false,
            "orderId" => "N/D",
            "formattedDate" => "N/D",
            "customerName" => "N/D",
            "customerEmail" => "N/D",
            "grossAmount" => "0.00 USD",
            "paypalFee" => "0.00 USD",
            "netAmount" => "0.00 USD",
            "items" => []
        );

        $token = $_GET["token"] ?? "";
        $session_token = $_SESSION["orderid"] ?? "";
        if (!empty($token) && $token === $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);
            $dataview["orderjson"] = json_encode($result, JSON_PRETTY_PRINT);

            $payer = $result->payer ?? null;
            $purchaseUnits = $result->purchase_units ?? [];
            $firstPurchaseUnit = $purchaseUnits[0] ?? null;
            $captures = $firstPurchaseUnit->payments->captures ?? [];
            $firstCapture = $captures[0] ?? null;
            $amount = $firstCapture->amount ?? null;
            $breakdown = $firstCapture->seller_receivable_breakdown ?? null;
            $currency = $amount->currency_code ?? ($breakdown->net_amount->currency_code ?? "USD");

            $dataview["hasOrder"] = true;
            $dataview["orderId"] = $firstCapture->id ?? ($result->id ?? "N/D");
            $dataview["formattedDate"] = $this->formatDate(
                $firstCapture->update_time ?? ($result->update_time ?? "")
            );
            $dataview["customerName"] = trim(
                ($payer->name->given_name ?? "") . " " . ($payer->name->surname ?? "")
            ) ?: "N/D";
            $dataview["customerEmail"] = $payer->email_address ?? "N/D";
            $dataview["grossAmount"] = $this->formatAmount($amount->value ?? 0, $currency);
            $dataview["paypalFee"] = isset($breakdown->paypal_fee->value)
                ? $this->formatAmount($breakdown->paypal_fee->value, $breakdown->paypal_fee->currency_code ?? $currency)
                : "0.00 " . $currency;
            $dataview["netAmount"] = isset($breakdown->net_amount->value)
                ? $this->formatAmount($breakdown->net_amount->value, $breakdown->net_amount->currency_code ?? $currency)
                : $this->formatAmount($amount->value ?? 0, $currency);

            if (!empty($firstPurchaseUnit->items)) {
                foreach ($firstPurchaseUnit->items as $index => $item) {
                    $quantity = isset($item->quantity) ? (int)$item->quantity : 1;
                    $unitAmount = $item->unit_amount->value ?? 0;
                    $itemsCurrency = $item->unit_amount->currency_code ?? $currency;
                    $dataview["items"][] = array(
                        "row" => $index + 1,
                        "itemName" => $item->name ?? "Producto",
                        "unitAmount" => $this->formatAmount($unitAmount, $itemsCurrency),
                        "quantity" => $quantity,
                        "total" => $this->formatAmount($unitAmount * $quantity, $itemsCurrency)
                    );
                }
            }
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
        }
        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
