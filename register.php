<?php
include 'db.php';

$nombre = $_POST['nombre'];
$email = $_POST['email'];
$pass = password_hash($_POST['password'], PASSWORD_DEFAULT);

$sql = "INSERT INTO users (nombre, email, password) VALUES ('$nombre', '$email', '$pass')";

if ($conn->query($sql) === TRUE) {
    echo "✅ Registro exitoso. <a href='login.html'>Iniciar sesión</a>";
} else {
    echo "❌ Error: " . $conn->error;
}

$conn->close();
?>
