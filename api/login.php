<?php
include("../db.php");
session_start();

$data = json_decode(file_get_contents("php://input"), true);

$username = trim($data["username"] ?? "");
$password = $data["password"] ?? "";
$role     = $data["role"] ?? "";

if ($username === "" || $password === "" || ($role !== "Admin" && $role !== "Employee")) {
    http_response_code(400);
    echo "Invalid input";
    exit;
}

/* 1) First check: username exists? (role ignore) */
$stmt = $conn->prepare("SELECT user_id, username, password, role FROM users WHERE username=? LIMIT 1");
$stmt->bind_param("s", $username);
$stmt->execute();
$res = $stmt->get_result();

if ($res->num_rows !== 1) {
    http_response_code(401);
    echo "Invalid username or password";
    exit;
}

$user = $res->fetch_assoc();

/* 2) Role match? */
if ($user["role"] !== $role) {
    http_response_code(403);
    echo "Role mismatch (select correct role)";
    exit;
}

/* 3) Password match? */
if (!password_verify($password, $user["password"])) {
    http_response_code(401);
    echo "Invalid username or password";
    exit;
}

/* ✅ Success */
$_SESSION["user_id"]  = $user["user_id"];
$_SESSION["username"] = $user["username"];
$_SESSION["role"]     = $user["role"];

echo "success";
