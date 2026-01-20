<?php
include("../db.php");
include("auth.php");
require_login();

header("Content-Type: text/plain");

$data = json_decode(file_get_contents("php://input"), true);
$account_id = intval($data["account"] ?? 0);
$amount = floatval($data["amount"] ?? 0);

if ($account_id <= 0 || $amount <= 0) {
  echo "Invalid input";
  exit;
}

// account আছে কিনা check
$chk = $conn->prepare("SELECT balance FROM accounts WHERE account_id=?");
$chk->bind_param("i", $account_id);
$chk->execute();
$res = $chk->get_result();
if ($res->num_rows === 0) {
  echo "Account not found";
  exit;
}

// update balance + insert txn (atomic)
$conn->begin_transaction();
try {
  $up = $conn->prepare("UPDATE accounts SET balance = balance + ? WHERE account_id = ?");
  $up->bind_param("di", $amount, $account_id);
  $up->execute();

  $ins = $conn->prepare("INSERT INTO transactions (account_id, txn_type, amount) VALUES (?, 'Deposit', ?)");
  $ins->bind_param("id", $account_id, $amount);
  $ins->execute();

  $conn->commit();
  echo "Deposit successful";
} catch (Exception $e) {
  $conn->rollback();
  echo "Deposit failed";
}
