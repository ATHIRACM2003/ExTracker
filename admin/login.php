<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Your database connection code goes here
    $servername = 'localhost';
    $username_db = 'root'; // Corrected variable name
    $password_db = '';     // Corrected variable name
    $database = "expense_management";
    
    // Create connection
    $conn = new mysqli($servername, $username_db, $password_db, $database); // Corrected variable names

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepare and execute SQL statement to retrieve plain text password based on username
    $stmt = $conn->prepare("SELECT password FROM admin WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 1) {
        $row = $result->fetch_assoc();
        $plainTextPasswordFromDatabase = $row['password'];

        // Verify password
        if ($password == $plainTextPasswordFromDatabase) {
            // Password is correct, log in the user
            $_SESSION['username'] = $username;
            header("Location: index.php"); // Redirect to the dashboard page
            exit;
        } else {
            // Password is incorrect
            $error = "Invalid password";
        }
    } else {
        // Username not found
        $error = "Invalid username ";
    }

    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            padding: 0;
            background-color: #f2f2f2;
            text-align:center;
            margin-top: 170px;
        }
        #buton{
            display: inline-block;
            padding: 10px 20px;
            height: 42px;
            width:180px;
            /* margin-left:36px; */
            background-color: #000036;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            transition: background-color 0.3s;
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
        }
        #buton:hover {
            background-color: #45a049; 
        }
         h2
        {
            font-family:Arial;
            font-size:40px;
        } 
        .formm{
            display: inline-block;
        }
        input{
            padding-left:7px;
            width:220px;
            height:32px;
            border-radius: 10px;
            border-color:#d3d3d3;
        }
    </style>
</head>
<body>
    <h2>Login</h2>
    <?php if (isset($error)) echo "<p>$error</p>"; ?>
    <form class="formm" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
        <!-- <label for="username">Username:</label><br> -->
        <input placeholder="Username" type="text" id="username" name="username" required><br><br>
        <!-- <abel for="password">Password:</label><br> -->
        <input placeholder="Password" type="password" id="password" name="password" required><br><br>
        <input type="submit" value="Login" id="buton">
    </form>
</body>
</html>
