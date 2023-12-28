
<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "expense_management";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);


  if( !empty($_POST["category"]))
{

      $category = $_POST["category"];

   
               
      
      $category=mysqli_real_escape_string($connection,$category);
 
     

      

 
 

 

    $sql = "INSERT INTO  add_category (category) VALUES ('".$category."')";


    if ( mysqli_query($connection, $sql) ) {
        $result["error"] = false;
        $result["message"] = "Registration success";
		 echo json_encode($result);
        mysqli_close($connection);
    }
    
      
}   

       

    
	
?>

