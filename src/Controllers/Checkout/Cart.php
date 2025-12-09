<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Cart\Cart as CartDao;
use Utilities\Cart\CartFns;
use Utilities\Security;
use Utilities\Site;

class Cart extends PublicController
{
    public function run(): void
    {
        $viewData = [];
        $carretilla = $this->getCurrentCart();

        if ($this->isPostBack()) {
            $this->handleCartActions();
            $carretilla = $this->getCurrentCart();
        }

        $mappedCart = [];
        $counter = 1;
        $total = 0;
        foreach ($carretilla as $prod) {
           $productoDisp = CartDao::getProductoDisponible($prod["productId"]);
            $unitPrice = floatval($prod["crrprc"]);
            $prod["row"] = $counter;
            $prod["subtotal"] = number_format($unitPrice * $prod["crrctd"], 2);
            $prod["crrprc"] = number_format($unitPrice, 2);
            $prod["canAddMore"] = ($productoDisp && $productoDisp["productStock"] > 0);
            $prod["productStock"] = $productoDisp["productStock"] ?? 0;
            $total += $unitPrice * $prod["crrctd"];
            $mappedCart[] = $prod;
            $counter++;
        }

        $viewData["carretilla"] = $mappedCart;
        $viewData["total"] = number_format($total, 2);
        $viewData["isEmpty"] = count($mappedCart) === 0;
        $viewData["checkoutLabel"] = $viewData["isEmpty"] ? "Seguir comprando" : "Ir al checkout";
        \Views\Renderer::render("paypal/cart", $viewData);
    }

    private function getCurrentCart(): array
    {
        if (Security::isLogged()) {
            return CartDao::getAuthCart(Security::getUserId());
        }
        $annonCod = CartFns::getAnnonCartCode();
        return CartDao::getAnonCart($annonCod);
    }

    private function handleCartActions(): void
    {
        if (isset($_POST["proceedToCheckout"])) {
            $carretilla = $this->getCurrentCart();
            if (count($carretilla) === 0) {
                Site::redirectTo("index.php?page=HomeController");
            }
            if (!Security::isLogged()) {
                Site::redirectTo("index.php?page=Sec_Login");
            }
            Site::redirectTo("index.php?page=Checkout_Checkout");
        }

        if (isset($_POST["removeOne"]) || isset($_POST["addOne"])) {
            $productId = intval($_POST["productId"]);
            $productoDisp = CartDao::getProductoDisponible($productId);
            $amount = isset($_POST["removeOne"]) ? -1 : 1;

            if (!$productoDisp) {
                return;
            }

            if ($amount === 1 && ($productoDisp["productStock"] ?? 0) - $amount < 0) {
                return;
            }

            $price = $productoDisp["productPrice"] ?? 0;

            if (Security::isLogged()) {
                CartDao::addToAuthCart(
                    $productId,
                    Security::getUserId(),
                    $amount,
                    $price
                );
            } else {
                $anonCod = CartFns::getAnnonCartCode();
                CartDao::addToAnonCart(
                    $productId,
                    $anonCod,
                    $amount,
                    $price
                );
            }
            $this->getCartCounter();
        }
    }
}
