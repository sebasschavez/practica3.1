<?php
$host = "gondola.proxy.rlwy.net";
$user = "root";
$pass = "KugVhFVrKcwcBPzWxRJbmHKpKDUdexqK";
$db   = "railway";
$port = 27604;

$conn = new mysqli($host, $user, $pass, $db, $port);

if ($conn->connect_error) {
    die("❌ Error de conexión: " . $conn->connect_error);
}
?>
