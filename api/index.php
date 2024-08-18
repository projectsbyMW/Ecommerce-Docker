<?php
header("Content-Type: application/json");
header('Access-Control-Allow-Origin: http://localhost:3000');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

session_start();
file_put_contents('php://stderr', print_r($_GET, TRUE)); // Log to the error log

require "./app/config.php";
require_once "./app/web_commerce.php";

$productModel = new Products();
$products = $productModel->getProducts(10);

$cart = [];

// Determine the API action based on the 'action' parameter in the query string
$action = isset($_GET['action']) ? $_GET['action'] : null;

switch ($action) {
    case 'getProducts':
        getProducts();
        break;
    case 'getProductDetails':
        getProductDetails();
        break;
    case 'addToCart':
        addToCart();
        break;
    case 'getCart':
        getCart();
        break;
    default:
        echo json_encode(["error" => "Invalid action"]);
        break;
}

// Function to get all products
function getProducts() {
    global $products;
    echo json_encode($products);
}

// Function to get details of a single product by ID
function getProductDetails() {
    global $products;
    $id = isset($_GET['id']) ? intval($_GET['id']) : null;
    
    if ($id === null) {
        echo json_encode(["error" => "Product ID is required"]);
        return;
    }

    foreach ($products as $product) {
        if ($product['id'] === $id) {
            echo json_encode($product);
            return;
        }
    }

    echo json_encode(["error" => "Product not found"]);
}

// Function to add a product to the cart
function addToCart() {
    global $cart, $products;
    $id = isset($_GET['id']) ? intval($_GET['id']) : null;

    if ($id === null) {
        echo json_encode(["error" => "Product ID is required"]);
        return;
    }

    foreach ($products as $product) {
        if ($product['id'] === $id) {
            $cart[] = $product;
            echo json_encode(["message" => "Product added to cart", "cart" => $cart]);
            return;
        }
    }

    echo json_encode(["error" => "Product not found"]);
}

// Function to get the current cart contents
function getCart() {
    global $cart;
    echo json_encode($cart);
}

?>