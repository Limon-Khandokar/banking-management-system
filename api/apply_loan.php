<?php
include("../db.php");
$data = json_decode(file_get_contents("php://input"), true);

$sql = "INSERT INTO loans (customer_id,amount,emi)
VALUES ('{$data['customer']}','{$data['amount']}','{$data['emi']}')";

echo ($conn->query($sql)) ? "Loan Applied" : "Error";
?>
