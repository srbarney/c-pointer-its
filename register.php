<?php
// REGISTER.PHP - Handles registration form processing

// Start a session to store user data
session_start();
require_once "includes/functions.php";

if(isset($_POST['register']) && isset($_POST['reg_email']) && isset($_POST['reg_password'])) {
    $extra = htmlspecialchars($_POST["reg_extra"]);
    if(empty($extra))
    {
        $reg_fname = htmlspecialchars($_POST['reg_fname']);
        $reg_lname = htmlspecialchars($_POST['reg_lname']);
        $reg_email = htmlspecialchars($_POST['reg_email']);
        $passlength = strlen($_POST['reg_password']);
        $password = md5(htmlspecialchars($_POST['reg_password']));
        $repass = md5(htmlspecialchars($_POST['reg_repassword']));
        $reg_ip = getClientIP();

        // Check for matching passwords
        if(!strcmp($password, $repass))
        {
            // Check for valid email
            if(isValidEmail($reg_email))
            {
                // Open DB connection ($link)
                require "db/main_db_open.php";

                // Generate token for user
                $tok = generateToken($reg_email);
                $tok_valid = getTokenTimeout();

                // Set rank to be student (default)
                $rank = 1;

                // Check for duplicate email
                $query = "SELECT * FROM reg_users WHERE email='" . $reg_email . "';";
                $result = mysql_query($query);
                if(mysql_numrows($result) != 0)
                {
                    denyAccess();
                    $_SESSION['message'] = 'E-mail ' . $reg_email . ' is already registered. Please use a different e-mail. If you have forgotten your password please click the "Forgot Password" link on the <a href="/index.html">Home</a> page.';
                    formRedirectBack();
                    exit;
                }

                // Insert values into user DB
                mysql_query("INSERT INTO reg_users(first_name, last_name, password, email, rank, token, token_validity, reg_ip) VALUES ('$reg_fname','$reg_lname', '$password','$reg_email', '$rank', '$tok', '$tok_valid', '$reg_ip')") or die("".mysql_error());

                // Notify admin that user has registered
                $email_message = $reg_fname . " " . $reg_lname . " (" . $reg_email . ")\n\nHas registered for access on The C Pointer Tutor.";
                $to = $FORM_EMAIL_ADMIN;
                $subject = "The C Pointer Tutor - User Registration";
                $headers = "From:" . $reg_email;
                mail($to,$subject,$email_message,$headers);

                // Send user message letting them know they have registered
                sendVerifToken($reg_email);

                // Close DB connection
                require "db/main_db_close.php";

                // Destroy session
                session_destroy();

                // Reset Session
                session_start();
                denyAccess();
                $_SESSION['message'] = 'Registration successful. To complete registration you must verfiy your e-mail account. Please check your e-mail inbox for the message containing a link to complete your registration.';

                // Redirect to homepage
                formRedirectBack();
                exit;
            }
            else
            {
                $_SESSION['message'] = 'E-mail is invalid. Please try again.';
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