
<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "expense_management";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);


   if( !empty($_POST["amount"])and !empty($_POST["type"])and !empty($_POST["note"])and !empty($_POST["date"])
	and !empty($_POST["category"]) and !empty($_POST["budget_limit_value_send"])   
   )
	 
{

      $amount = $_POST["amount"];
    $type= $_POST["type"];
	 $note= $_POST["note"];
	 $date= $_POST["date"];
	  $category= $_POST["category"];
	  $budget_limit_value_send= $_POST["budget_limit_value_send"];
   
               
      
      $amount=mysqli_real_escape_string($connection,$amount);
     $type=mysqli_real_escape_string($connection,$type);
      $note=mysqli_real_escape_string($connection,$note);
	  $date=mysqli_real_escape_string($connection,$date);
	  $category=mysqli_real_escape_string($connection,$category);
	   $budget_limit_value_send=mysqli_real_escape_string($connection,$budget_limit_value_send);
     
     

      

 
 


    $sql = "INSERT INTO   transaction (amount,type,note,date,category,budget_limit_value_send) VALUES (
	'".$amount."','".$type."','".$note."','".$date."','".$category."','".$budget_limit_value_send."')";


    if ( mysqli_query($connection, $sql) ) {
        $result["error"] = false;
        $result["message"] = "Registration success";
		 echo json_encode($result);
        mysqli_close($connection);
    }
    
      
}   

       

    
	
?>

