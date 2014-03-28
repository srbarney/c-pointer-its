<?php
// VERIFY-EMAIL.PHP - Handles e-mail account validation

// Start a session to store user data
session_start();
require_once "includes/functions.php";

// Validate the user token
validateToken();

// Fetch users
$vftoken = $_GET['vftok'];

if(strlen($vftoken) > 30)
{
    // Find the given token in the user DB
    require "db/main_db_open.php";
    $query = "SELECT * FROM reg_users WHERE token='" . $vftoken . "';";
    $result = mysql_query($query);

    if(mysql_numrows($result) != 1)
    {
        // If the token was not found
        denyAccess();
        $_SESSION['message'] = 'Invalid registration token. Account may have already been verified. Please try to log in - if the problem continues contact us for more information.';
    }
    else
    {
        $old_stat = mysql_result($result, 0, "user_stat");
        // If user account is not verified yet - "Unverified"
        if ($old_stat == 'U')
        {
            // Token success - change user account status to "Active"
            $query = "UPDATE reg_users SET user_stat='A' WHERE token='" . $vftoken . "';";
            mysql_query($query);

            $_SESSION['message'] = 'Account has been verified. Please log in with your username and password to access the site.';
        }
        else
        {
            denyAccess();
            $_SESSION['message'] = 'Account has already been verified or is not eligible. Please contact us for more information.';
        }
    }

    // Close user DB
    require "db/main_db_close.php";
}
else
    $_SESSION['message'] = 'Error. Something went wrong. Please try again or contact us for more information.';

header('location: index.html');
?>

