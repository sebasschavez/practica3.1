<?php
$host = "shortline.proxy.rlwy.net";
$user = "root";
$password = "twmQfNBiPUmPsBohVEgEQOTIXCeUOjWc";
$dbname = "railway";
$port = 59604;

$conn = new mysqli($host, $user, $password, $dbname, $port);

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
} else {
    echo "Conexión exitosa ✅";
}
?>
