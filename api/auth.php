<?php
session_start();

function require_login() {
  if (!isset($_SESSION["user_id"])) {
    http_response_code(401);
    echo "Unauthorized";
    exit;
  }
}

function require_role($role) {
  require_login();
  if ($_SESSION["role"] !== $role) {
    http_response_code(403);
    echo "Forbidden";
    exit;
  }
}
