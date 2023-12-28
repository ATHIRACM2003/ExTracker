<?php 
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "expense_management";


$connection = new mysqli($servername, $username, $password,$database);
    

if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}

            $connection->set_charset("utf8");
            
            
				$id = $_POST['id'];
				$username = $_POST["username"];
				$email= $_POST["email"];
				$phone= $_POST["phone"];
				$password= $_POST["password"];

	$connection->query("UPDATE   user_registraion SET 
	
	username='".$username."',
	email='".$email."',
	phone='".$phone."',
	password='".$password."'

	WHERE id=".$id);




	



    	
	$result = array();
	$result['msg'] = "Successfully Edited..";
	echo json_encode($result);

?>



