<?php
include("../db.php");
$data = json_decode(file_get_contents("php://input"), true);

$sql = "INSERT INTO customers (name,email,phone,address)
VALUES ('{$data['name']}','{$data['email']}','{$data['phone']}','{$data['address']}')";

echo ($conn->query($sql)) ? "Customer Created" : "Error";
?>
