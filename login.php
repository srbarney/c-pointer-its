<?php
// LOGIN.PHP - Handles login form processing

// Start a session to store user data
session_start();
require_once "includes/functions.php"; // For getClientIP();

if(isset($_POST['login'])) {
    $ip = getClientIP();
    $current_user = htmlspecialchars($_POST["log_email"]);
    $password = md5(htmlspecialchars($_POST["log_password"]));
    $login_success = 0;

    // Open DB connection ($link)
    require "db/main_db_open.php";

    // Check username/password against database
    $query = "SELECT * FROM reg_users WHERE (username='" . $current_user . "' OR email='" . $current_user ."') AND password='" . $password . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) != 1) {
        // If the username/e-mail and password combination was not found in database
        denyAccess();
        $_SESSION['message'] = 'Incorrect login information. If you have forgot your login or password please click the "Forgot Username/Password" link.';
        $header = "location: /register.html";
        header($header);
    }
    else {
        // Fetch user account status and username
        $user_stat = mysql_result($result, 0, "user_stat");
        $user_name = mysql_result($result, 0, "username");

        if ($user_stat == 'X')
        {
            denyAccess();
            $_SESSION['message'] = 'The account registered under the username ' . $user_name . ' has been banned. Please contact us for more information.';
            formRedirectBack();
        }
        else if($user_stat == 'U')
        {
            denyAccess();
            $_SESSION['message'] = 'The account registered under the username ' . $user_name . ' has not been verified. The activation message has been resent - please check your e-mail inbox for the message containing a link to complete your registration.';
            require "db/main_db_close.php";
            resendVerifToken($user_name);
            require "db/main_db_open.php";
            formRedirectBack();
        }
        else
        {
            // Fetch rank
            $rank = mysql_result($result, 0, "rank");
            $token = generateToken($current_user);

            // Set session variables
            $_SESSION['firstname'] = mysql_result($result, 0, "first_name");
            $_SESSION['lastname'] = mysql_result($result, 0, "last_name");
            $_SESSION['username'] = mysql_result($result, 0, "username");
            $_SESSION['rank'] = $rank;
            $_SESSION['status'] = 1;
            $_SESSION['token'] = $token;
            $_SESSION['message'] = 'Login successful.';
            $login_success = 1;

            // Set last_login
            $query = "UPDATE reg_users SET last_login='" . date('Y-m-d H:i:s') . "' WHERE username='" . $current_user . "';";
            mysql_query($query);

            // Set token
            $query = "UPDATE reg_users SET token='" . $token . "' WHERE username='" . $current_user . "';";
            mysql_query($query);

            // Set token_validity
            $query = "UPDATE reg_users SET token_validity='" . getTokenTimeout() . "' WHERE username='" . $current_user . "';";
            mysql_query($query);

            // Redirect back to referring page
            formRedirectBack();
        }
    }

    // Create login_attempt entry
    mysql_query("INSERT INTO reg_login_attempt(ip, username, login_success) VALUES ('$ip','$current_user', '$login_success')") or die("".mysql_error());

    // Close DB connection
    require "db/main_db_close.php";
}
else
{
    denyAccess();
    $_SESSION['message'] = 'Error logging in.';
    $header = "location: /register.html";
    header($header);
}

exit;
?>