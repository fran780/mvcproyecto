<?php

namespace Dao\Products;

use Dao\Table;

class Products extends Table
{
    public static function getAll()
    {
        return self::obtenerRegistros("SELECT * FROM products", []);
    }

    public static function getByPrimaryKey($productId)
    {
        return self::obtenerUnRegistro(
            "SELECT * FROM products WHERE productId = :productId;",
            ["productId" => $productId]
        );
    }

    public static function add($productName = null, $productDescription = null, $productPrice = null, $productImgUrl = null, $productStock = null, $productStatus = null)
    {
        return self::executeNonQuery(
            "INSERT INTO products ( productName, productDescription, productPrice, productImgUrl, productStock, productStatus) VALUES (:productName, :productDescription, :productPrice, :productImgUrl, :productStock, :productStatus);",
            ["productName" => $productName, "productDescription" => $productDescription, "productPrice" => $productPrice, "productImgUrl" => $productImgUrl, "productStock" => $productStock, "productStatus" => $productStatus]
        );
    }

    public static function update($productId = null, $productName = null, $productDescription = null, $productPrice = null, $productImgUrl = null, $productStock = null, $productStatus = null)
    {
        return self::executeNonQuery(
            "UPDATE products SET productName = :productName, productDescription = :productDescription, productPrice = :productPrice, productImgUrl = :productImgUrl, productStock = :productStock, productStatus = :productStatus WHERE productId = :productId;",
            ["productId" => $productId, "productName" => $productName, "productDescription" => $productDescription, "productPrice" => $productPrice, "productImgUrl" => $productImgUrl, "productStock" => $productStock, "productStatus" => $productStatus]
        );
    }

    public static function delete($productId = null)
    {
        return self::executeNonQuery(
            "DELETE FROM products WHERE productId = :productId;",
            ["productId" => $productId]
        );
    }

    public static function getFeaturedProducts() {
    $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, productStock, p.productStatus FROM products p INNER JOIN highlights h ON p.productId = h.productId order by h.highlightStart DESC LIMIT 6";
    $params = [];
    $registros = self::obtenerRegistros($sqlstr, $params);
    return $registros;
  }

  public static function getNewProducts() {
    $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, productStock, p.productStatus FROM products p WHERE p.productStatus = 'ACT' ORDER BY p.productId DESC LIMIT 3";
    $params = [];
    $registros = self::obtenerRegistros($sqlstr, $params);
    return $registros;
  }

  public static function getDailyDeals() {
    $sqlstr = "SELECT p.productId, p.productName, p.productDescription, s.salePrice as productPrice, p.productImgUrl, productStock, p.productStatus FROM products p INNER JOIN sales s ON p.productId = s.productId order by s.saleStart DESC LIMIT 3";
    $params = [];
    $registros = self::obtenerRegistros($sqlstr, $params);
    return $registros;
  }
}
