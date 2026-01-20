<?php
include("../db.php");
$data = json_decode(file_get_contents("php://input"), true);

$conn->query("UPDATE loans SET status='Approved' WHERE loan_id={$data['loan_id']}");
echo "Loan Approved";
?>
