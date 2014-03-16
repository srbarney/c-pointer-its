<?php
// REGISTER.PHP - Handles registration form processing

// Start a session to store user data
session_start();
require_once "includes/functions.php";

if(isset($_POST['register']) && isset($_POST['reg_username']) && isset($_POST['reg_password'])) {
    $extra = htmlspecialchars($_POST["reg_extra"]);
    if(empty($extra))
    {
        $reg_user = htmlspecialchars($_POST['reg_username']);
        $reg_fname = htmlspecialchars($_POST['reg_fname']);
        $reg_lname = htmlspecialchars($_POST['reg_lname']);
        $passlength = strlen($_POST['reg_password']);
        $password = md5(htmlspecialchars($_POST['reg_password']));
        $repass = md5(htmlspecialchars($_POST['reg_repassword']));
        $reg_email = htmlspecialchars($_POST['reg_email']);
        $reg_org = htmlspecialchars($_POST['reg_org']);
        $reg_ip = getClientIP();

        // Check for matching passwords
        if(!strcmp($password, $repass))
        {
            // Check for valid username
            if(isAlphaNumeric($reg_user) && strlen($reg_user) >= 6)
            {
                $note = htmlspecialchars($_POST["reg_note"]);
                if (mb_strlen($note, 'UTF-8') <= ($MESSAGE_CHAR_MAX))
                {
                    // Open DB connection ($link)
                    require "includes/user_db_open.php";

                    // Generate token for user
                    $tok = generateToken($reg_user);
                    $tok_valid = getTokenTimeout();

                    // Set rank to be public (default)
                    $rank = 0;

                    // Check for duplicate username
                    $query = "SELECT * FROM reg_users WHERE username='" . $reg_user . "';";
                    $result = mysql_query($query);
                    if(mysql_numrows($result) != 0)
                    {
                        denyAccess();
                        $_SESSION['message'] = 'Username ' . $reg_user . ' is already registered. Please choose another username. If you forgot your username or password please click the "Forgot Username/Password" link on the <a href="/index.html">Home</a> page.';
                        formRedirectBack();
                        exit;
                    }

                    // Check for duplicate email
                    $query = "SELECT * FROM reg_users WHERE email='" . $reg_email . "';";
                    $result = mysql_query($query);
                    if(mysql_numrows($result) != 0)
                    {
                        denyAccess();
                        $_SESSION['message'] = 'The e-mail Address ' . $reg_email . ' Is already registered. If you forgot your username or password please click the "Forgot Username/Password" link on the <a href="/index.html">Home</a> page.';
                        formRedirectBack();
                        exit;
                    }

                    // Insert values into user DB
                    mysql_query("INSERT INTO reg_users(username, first_name, last_name, organization, password, email, rank, token, token_validity, reg_ip) VALUES ('$reg_user','$reg_fname','$reg_lname','$reg_org','$password','$reg_email', '$rank', '$tok', '$tok_valid', '$reg_ip')") or die("".mysql_error());

                    // Notify admin that user has registered
                    $email_message = "Username: " . $reg_user . "\nE-mail: " . $reg_email . "\n\nHas registered for access on severtsonscreens.com.\n\n-- Begin Message --\n\n" . $note . "\n\n-- End of Message --";
                    $to = $FORM_EMAIL_ADMIN;
                    $subject = "Severtson User Registration";
                    $headers = "From:" . $reg_email;
                    mail($to,$subject,$email_message,$headers);

                    // Send user message letting them know they have registered
                    $from = $FORM_EMAIL_NO_REPLY;
                    $to = $reg_email;
                    $email_message = "-- Begin Message --\n\nYou are receiving this message because you registered an account at www.severtsonscreens.com.\n\nYour username is: " . $reg_user . " \n\nPlease follow the link below to verify your account and complete registration.\n\n http://severtsonscreens.com/acct_verif.php?vftok=" . $tok . ".\n\n  If you cannot select the link above then please copy and paste it into your browser address bar.\n\n-- End of Message --";
                    $subject = "Welcome to severtsonscreens.com";
                    $headers = "From: " . $from;
                    mail($to,$subject,$email_message,$headers);

                    // Close DB connection
                    require "includes/user_db_close.php";

                    // Destroy session
                    session_destroy();

                    // Reset Session
                    session_start();
                    $_SESSION['username'] = '';
                    $_SESSION['status'] = 0;
                    $_SESSION['rank'] = -1;
                    unset($_SESSION['token']);
                    $_SESSION['message'] = 'Registration successful. To complete registration you must verfiy your e-mail account. Please check your e-mail inbox for the message containing a link to complete your registration.';

                    // Redirect to homepage
                    formRedirectBack();
                    exit;
                }
                else
                    $_SESSION['message'] = 'Your message can not be longer than ' . $MESSAGE_CHAR_MAX . ' characters.';
            }
            else
            {
                $_SESSION['message'] = 'Username is invalid. It must be at least 6 characters long and can only contain letters, numbers, or underscores. Please try again.';
                formRedirectBack();
                exit;
            }
        }
        else
            $_SESSION['message'] = 'Passwords must match. Please try again.';
    }
    else
        $_SESSION['message'] = 'Please leave the "Security" field empty. This is an anti-spam measure.';
}
else {
    $_SESSION['message'] = 'Error registering. Please try again.';
    formRedirectBack();
    exit;
}
?>