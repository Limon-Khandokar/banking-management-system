<?php
include("../db.php");
$data = json_decode(file_get_contents("php://input"), true);

$sql = "INSERT INTO accounts (customer_id,account_type,balance)
VALUES ('{$data['customer_id']}','{$data['type']}','{$data['deposit']}')";

echo ($conn->query($sql)) ? "Account Created" : "Error";
?>
