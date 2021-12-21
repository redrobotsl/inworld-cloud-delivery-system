<?php
$purpose    = $_REQUEST['purpose'];
$auth       = $_REQUEST['auth'];
$actualauth = "";
$item       = $_REQUEST['item'];
$uuid       = $_REQUEST['uuid'];

if ($_REQUEST['auth'] != $actualauth) {
    echo "UNAUTHORIZED";
    exit();
}
// assuming a named submit button

$servername = "localhost";
$username   = '';
$password   = '';
$dbname     = "";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql    = "SELECT `url` FROM `url` WHERE `id`='" . $purpose . "' LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    $row     = $result->fetch_assoc();
    $inworld = $row["url"];
    
    
    
    $data = array(
        'auth' => '',
        'item' => $item,
        'uuid' => $uuid
    );
    
    
    $curl = curl_init($inworld);
    curl_setopt($curl, CURLOPT_URL, $inworld);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    
    $headers = array(
        "Content-Type: application/json"
    );
    curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
    
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
    
    $resp = curl_exec($curl);
    curl_close($curl);
    //var_dump( $resp);
    
    echo $resp;
    
    
    
} else {
    echo "NOTFOUND";
}
$conn->close();


?>
