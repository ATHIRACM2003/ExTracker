<?php
session_start();
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}

// Assuming you have a database connection established earlier
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "expense_management";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);

// Check if the form is submitted for deleting a user
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['user_id'])) {
        $userId = $_POST['user_id'];

        // Delete user from the database
        $sql = "DELETE FROM user_registraion WHERE id = $userId";
        if (mysqli_query($connection, $sql)) {
            echo "User deleted successfully";
        } else {
            echo "Error deleting user: " . mysqli_error($connection);
        }
    }
}

// Fetch all users from the database
$sql = "SELECT id, username, email FROM user_registraion";
$result = mysqli_query($connection, $sql);
$users = mysqli_fetch_all($result, MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        header {
            background-color:#000036;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        nav ul {
            list-style-type: none;
            padding: 0;
        }

        nav ul li {
            display: inline;
            margin-right: 20px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
        }

        main {
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #000036;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        button {
            background-color: #dc143c ;
            /* Red background color */
            color: #ffffff;
            /* White text color */
            border: none;
            /* No border */
            padding: 5px 10px;
            /* Padding */
            border-radius: 5px;
            /* Rounded corners */
            cursor: pointer;
            /* Cursor style */
            transition: background-color 0.3s;
            /* Smooth transition for background color */
        }

        /* Hover style for the delete button */
        button:hover {
            background-color: #cc0000;
            /* Darker red background color on hover */
        }
    </style>
    <!-- <link rel="stylesheet" type="text/css" href="style.css"> -->
</head>

<body>
    <header>
        <h1>Welcome,
            <?php echo $_SESSION['username']; ?>!
        </h1>
        <nav>
            <ul>
                <li><a href="dashboard.php">Dashboard</a></li>
                <li><a href="index.php">Homepage</a></li>
                <li><a href="logout.php">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h2>All Users</h2>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Action</th> <!-- New column for delete action -->
                </tr>
            </thead>
            <tbody>
                <?php foreach ($users as $user): ?>
                    <tr>
                        <td>
                            <?php echo $user['id']; ?>
                        </td>
                        <td>
                            <?php echo $user['username']; ?>
                        </td>
                        <td>
                            <?php echo $user['email']; ?>
                        </td>
                        <!-- Add more columns if needed -->
                        <td>
                            <form id="deleteForm_<?php echo $user['id']; ?>" method="POST"
                                action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                                <!-- Form for delete action -->
                                <input type="hidden" name="user_id" value="<?php echo $user['id']; ?>">
                                <!-- Hidden field to store user ID -->
                                <button type="button" onclick="confirmDelete(<?php echo $user['id']; ?>)">Delete</button>
                                <!-- Delete button -->
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </main>

    <script>
        function confirmDelete(userId) {
            if (confirm("Are you sure you want to delete this user?")) {
                document.getElementById('deleteForm_' + userId).submit();
            }
        }
    </script>
</body>

</html>