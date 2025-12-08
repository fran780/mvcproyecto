<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;
use Utilities\Context;

class Checkout extends PublicController
{
    public function run(): void
    {
        /*
        1) Mostrar el listado de productos a facturar y los detalles y totales de la proforma.
        2) Al dar click en Pagar
            2.1) Crear una orden de Paypal con los productos de la proforma.
            2.2) Redirigir al usuario a la página de Paypal para que complete el pago.
        
        */
        $viewData = array();
        $isLogged = Security::isLogged();
        $anonCartCode = $isLogged ? null : \Utilities\Cart\CartFns::getAnnonCartCode();

        $carretilla = $isLogged
            ? Cart::getAuthCart(Security::getUserId())
            : Cart::getAnonCart($anonCartCode);
        if ($this->isPostBack()) {
            $processPayment = true;
            if (isset($_POST["removeOne"]) || isset($_POST["addOne"])) {
                $productId = intval($_POST["productId"]);
                $productoDisp = Cart::getProductoDisponible($productId);
                $amount = isset($_POST["removeOne"]) ? -1 : 1;
                if ($productoDisp) {
                    if ($amount == 1) {
                        if ($productoDisp["productStock"] - $amount >= 0) {
                            if ($isLogged) {
                                Cart::addToAuthCart(
                                    $productId,
                                    Security::getUserId(),
                                    $amount,
                                    $productoDisp["productPrice"]
                                );
                            } else {
                                Cart::addToAnonCart(
                                    $productId,
                                    $anonCartCode,
                                    $amount,
                                    $productoDisp["productPrice"]
                                );
                            }
                        }
                    } else {
                        if ($isLogged) {
                            Cart::addToAuthCart(
                                $productId,
                                Security::getUserId(),
                                $amount,
                                $productoDisp["productPrice"]
                            );
                        } else {
                            Cart::addToAnonCart(
                                $productId,
                                $anonCartCode,
                                $amount,
                                $productoDisp["productPrice"]
                            );
                        }
                    }
                }
                $carretilla = $isLogged
                    ? Cart::getAuthCart(Security::getUserId())
                    : Cart::getAnonCart($anonCartCode);
                $this->getCartCounter();
                $processPayment = false;
            }

            if ($processPayment) {
                if (!$isLogged) {
                    $redirTo = urlencode(Context::getContextByKey("request_uri"));
                    Site::redirectTo("index.php?page=sec.login&redirto=" . $redirTo);
                    return;
                }
                $PayPalOrder = new \Utilities\PayPal\PayPalOrder(
                    "test" . (time() - 10000000),
                    "http://localhost:8080/proyectofinal/index.php?page=Checkout_Error",
                    "http://localhost:8080/proyectofinal/index.php?page=Checkout_Accept"
                );

                /*foreach ($viewData["carretilla"] as $producto) {
                    $PayPalOrder->addItem(
                        $producto["productName"],
                        $producto["productDescription"],
                        $producto["productId"],
                        $producto["crrprc"],
                        0,
                        $producto["crrctd"],
                        "DIGITAL_GOODS"
                    );
                }*/
                foreach ($carretilla as $producto) {
                    $cantidad = intval($producto["crrctd"]);
                    $PayPalOrder->addItem(
                        $producto["productName"],
                        $producto["productDescription"],
                        $producto["productId"],
                        $producto["crrprc"],
                        0,
                        $cantidad,
                        "DIGITAL_GOODS"
                    );
                }

                $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                    \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                    \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
                );
                $PayPalRestApi->getAccessToken();
                $response = $PayPalRestApi->createOrder($PayPalOrder);

                $_SESSION["orderid"] = $response->id;
                foreach ($response->links as $link) {
                    if ($link->rel == "approve") {
                        \Utilities\Site::redirectTo($link->href);
                    }
                }
                die();
            }
        }
        $finalCarretilla = [];
        $counter = 1;
        $total = 0;
        foreach ($carretilla as $prod) {
            $cantidad = intval($prod["crrctd"]);
            $prod["row"] = $counter;
            $prod["crrctd"] = $cantidad;
            $prod["subtotal"] = number_format($prod["crrprc"] * $cantidad, 2);
            $total += $prod["crrprc"] * $cantidad;
            $prod["crrprc"] = number_format($prod["crrprc"], 2);
            $finalCarretilla[] = $prod;
            $counter++;
        }
        $cartItemCount = $isLogged
            ? Cart::getAuthCartCount(Security::getUserId())
            : Cart::getAnonCartCount($anonCartCode);
        Context::setContext("CART_ITEMS", $cartItemCount);
        $viewData["carretilla"] = $finalCarretilla;
        $viewData["total"] = number_format($total, 2);
        $viewData["isLogged"] = $isLogged;
        $viewData["loginUrl"] = "index.php?page=sec.login&redirto="
            . urlencode(Context::getContextByKey("request_uri"));
        \Views\Renderer::render("paypal/checkout", $viewData);
    }
}
