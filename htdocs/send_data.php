
<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "crud";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);


  if( !empty($_POST["name"])and !empty($_POST["age"]))
{

      $name = $_POST["name"];
    $age= $_POST["age"];
   
               
      
      $name=mysqli_real_escape_string($connection,$name);
     $age=mysqli_real_escape_string($connection,$age);
     

      

 
 

 $findexist="select * from  test where name='".$name."'";


         $resultsearch=mysqli_query($connection,$findexist);
        
  
    if(mysqli_num_rows($resultsearch)>0)
     {
           while($row=mysqli_fetch_array($resultsearch))
           {
              $result["success"] = "success";
              $result["message"] = "user Already exist";
			     $result["error"] = true;
               $result["message"] = "username Already exist try another!";

              echo json_encode($result);
              mysqli_close($connection);
           }}
  
 else{

    $sql = "INSERT INTO  test (name,age) VALUES ('".$name."','".$age."')";


    if ( mysqli_query($connection, $sql) ) {
        $result["error"] = false;
        $result["message"] = "Registration success";
		 echo json_encode($result);
        mysqli_close($connection);
    }
    
      
}   

       

    }
	
?>

