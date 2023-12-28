<?php 

$servername = 'localhost';
$username = 'root';
$password = '';
$database = "expense_management";


$connection = mysqli_connect($servername, $username, $password, $database);

if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}



 
	$connection->query("TRUNCATE TABLE transaction") ;
 

$result=array("success"=>'Successfully Deleted');
echo json_encode($result);

?>