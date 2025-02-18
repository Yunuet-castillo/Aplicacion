<?php
// Configuración de la conexión a la base de datos
$servername = "localhost";
$username = "root"; // Usuario de la base de datos
$password = ""; // Contraseña de la base de datos
$dbname = "aplicacion"; // Nombre de tu base de datos

$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica si la conexión fue exitosa
if ($conn->connect_error) {
    die(json_encode([
        "success" => false,
        "message" => "Error de conexión: " . $conn->connect_error
    ]));
}

// Verifica que la solicitud sea POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Recibe los datos enviados desde Flutter
    $nombre = $_POST['nombre'] ?? null;
    $fechaNacimiento = $_POST['fechaNacimiento'] ?? null;
    $edad = $_POST['edad'] ?? null;
    $escuela = $_POST['escuela'] ?? null;
    $correo = $_POST['correo'] ?? null;
    $contrasena = $_POST['contrasena'] ?? null;
 
    // Verifica que no haya datos vacíos
    if ($nombre && $fechaNacimiento && $edad && $escuela && $correo && $contrasena) {
        // Cifra la contraseña antes de guardarla
        $contrasenaCifrada = password_hash($contrasena, PASSWORD_BCRYPT);

        // Inserta los datos en la base de datos
        $sql = "INSERT INTO usuarios (nombre, fecha_nacimiento, edad, escuela, correo, contrasena) 
                VALUES ('$nombre', '$fechaNacimiento', '$edad', '$escuela', '$correo', '$contrasenaCifrada')";

        if ($conn->query($sql) === TRUE) {
            echo json_encode([
                "success" => true,
                "message" => "Registro exitoso"
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Error al guardar los datos: " . $conn->error
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Por favor, completa todos los campos"
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Método no permitido"
    ]);
}

$conn->close();
?>
