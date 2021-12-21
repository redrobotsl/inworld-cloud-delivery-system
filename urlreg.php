<?php

$url        = $_REQUEST['url'];
$purpose    = $_REQUEST['purpose'];
$auth       = $_REQUEST['auth'];
// Same AUTH as you have inworld.
$actualauth = "";

$mysql_hostname = 'localhost';
$mysql_username = '';
$mysql_password = '';
$mysql_dbname   = '';

try {
    $conn = new PDO("mysql:host=$mysql_hostname;dbname=$mysql_dbname", $mysql_username, $mysql_password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}
catch (PDOException $e) {
    exit($e->getMessage());
}

if ($_REQUEST['auth'] != $actualauth) {
    exit();
}
// assuming a named submit button


try {
    // prepare sql and bind parameters
    $sql = "UPDATE url SET url='" . $url . "' WHERE id='" . $purpose . "'";
    
    // Prepare statement
    $stmt = $conn->prepare($sql);
    
    // execute the query
    $stmt->execute();
    
    if ($stmt->rowCount() > 0) {
        // echo a message to say the UPDATE succeeded
        echo $stmt->rowCount() . " records UPDATED successfully";
    } else {
        $sql  = "INSERT INTO url (id, url) VALUES ('" . $purpose . "','" . $url . "')";
        // use exec() because no results are returned
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        echo "New record created successfully";
    }
}
catch (PDOException $e) {
    echo $sql . "<br>" . $e->getMessage();
}



?>
