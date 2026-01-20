<?php
include("../db.php");
include("auth.php");
require_login();

header("Content-Type: text/plain");

$data = json_decode(file_get_contents("php://input"), true);
$from = intval($data["from"] ?? 0);
$to = intval($data["to"] ?? 0);
$amount = floatval($data["amount"] ?? 0);

if ($from <= 0 || $to <= 0 || $amount <= 0 || $from === $to) {
  echo "Invalid input";
  exit;
}

// check from account balance
$chk = $conn->prepare("SELECT balance FROM accounts WHERE account_id=?");
$chk->bind_param("i", $from);
$chk->execute();
$res = $chk->get_result();
if ($res->num_rows === 0) { echo "From account not found"; exit; }
$bal = floatval($res->fetch_assoc()["balance"]);
if ($bal < $amount) { echo "Insufficient balance"; exit; }

// check to account exists
$chk2 = $conn->prepare("SELECT 1 FROM accounts WHERE account_id=?");
$chk2->bind_param("i", $to);
$chk2->execute();
$res2 = $chk2->get_result();
if ($res2->num_rows === 0) { echo "To account not found"; exit; }

$conn->begin_transaction();
try {
  $up1 = $conn->prepare("UPDATE accounts SET balance = balance - ? WHERE account_id = ?");
  $up1->bind_param("di", $amount, $from);
  $up1->execute();

  $up2 = $conn->prepare("UPDATE accounts SET balance = balance + ? WHERE account_id = ?");
  $up2->bind_param("di", $amount, $to);
  $up2->execute();

  // ✅ single clear log
  $ins = $conn->prepare("
    INSERT INTO transactions (account_id, txn_type, from_account, to_account, amount)
    VALUES (?, 'Transfer', ?, ?, ?)
  ");
  $account_id_for_log = $from; // log owner = sender
  $ins->bind_param("iiid", $account_id_for_log, $from, $to, $amount);
  $ins->execute();

  $conn->commit();
  echo "Transfer successful";
} catch (Exception $e) {
  $conn->rollback();
  echo "Transfer failed";
}
