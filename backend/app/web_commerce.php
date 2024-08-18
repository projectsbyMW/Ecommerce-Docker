<?php 
require_once "./app/Database.php";

class Products extends Database
{
    public function getProducts($limit)
    {
        return $this->select("SELECT * FROM products");
    }
}
