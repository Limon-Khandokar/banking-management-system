<?php
include("../db.php");
include("auth.php");
require_login();

header("Content-Type: application/json");

$account = isset($_GET["account"]) ? intval($_GET["account"]) : 0;

if ($account > 0) {
  // ✅ filter করলে from/to সহ দেখাবে
  $stmt = $conn->prepare("
    SELECT txn_id, account_id, txn_type, from_account, to_account, amount, txn_date
    FROM transactions
    WHERE account_id=?
    ORDER BY txn_id DESC
    LIMIT 100
  ");
  $stmt->bind_param("i", $account);
} else {
  $stmt = $conn->prepare("
    SELECT txn_id, account_id, txn_type, from_account, to_account, amount, txn_date
    FROM transactions
    ORDER BY txn_id DESC
    LIMIT 100
  ");
}

$stmt->execute();
$res = $stmt->get_result();

$rows = [];
while ($r = $res->fetch_assoc()) $rows[] = $r;

echo json_encode($rows);
