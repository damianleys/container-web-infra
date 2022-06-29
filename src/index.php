<?php
// require 'vendor/autoload.php'; // include Composer's autoloader
// print phpinfo();

// MySQL
$mysqlHost = getenv('DBENGINE_HOST');
$mysqlUser = getenv('DBENGINE_USER');
$mysqlPass = getenv('DBENGINE_PASSWORD');
$mysqlDb = getenv('DBENGINE_DATABASE');

// MongoDB
$mongoUser = getenv('MONGODB_USERNAME');
$mongoPassword = getenv('MONGODB_PASSWORD');
$mongoDb = getenv('MONGODB_DATABASE');
$mongoCollection = getenv('MONGODB_COLLECTION');

// check the MySQL connection status
$conn = new mysqli($mysqlHost, $mysqlUser, $mysqlPass, $mysqlDb);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
    exit();
}

$sql = 'SELECT * FROM users';

if ($result = $conn->query($sql)) {
    while ($data = $result->fetch_object()) {
        $users[] = $data;
    }
}

echo "dumping MARIADB results<br>";
foreach ($users as $user) {
    echo "<br>";
    echo $user->username . " " . $user->password;
    echo "<br>";
}

$conn -> close();


echo "================================ <br>";
// MONGODB
$manager = new MongoDB\Driver\Manager("mongodb://$mongoUser:$mongoPassword@mongo:27017/");   

$filter= [];
$options = array(
    'limit' => 10
);

$query = new MongoDB\Driver\Query($filter, $options);
$rows = $manager->executeQuery("$mongoDb.$mongoCollection", $query);

echo "dumping MONGODB results<br>";
foreach ($rows as $document) {
    echo "<br>";
    var_dump($document);
    echo "<br>";
}

?>