<?php

function clipString($string, $length = 10)
{
    $new_string = (strlen($string) > $length) ? substr($string,0,($length - 3)).'...' : $string;
    return $new_string;
}

function denyAccess() {
    $_SESSION['email'] = '';
    $_SESSION['status'] = 0;
    $_SESSION['rank'] = -1;
    unset($_SESSION['token']);
    unset($_SESSION['email']);
}

function formRedirectBack() {
    $http_ref = $_SERVER['HTTP_REFERER'];

    if(isset($_SESSION['destination_url'])) // If a destination was already set go to it
    {
        $dest_url = $_SESSION['destination_url'];
        unset($_SESSION['destination_url']);
        $header = "location: " . $dest_url;
    }
    else if($http_ref) // If a referrer page is set go back to it
        $header = "location: " . $http_ref;
    else // Otherwise go home
        $header = "location: index.html";

    header($header);
}

function generatePassword($length = 8) {
    // Returns a random password of given length
    $password = "";
    // Define possible characters
    $possible = "0123456789abcdfghjkmnpqrstvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $i = 0;
    // Add random characters to $password until $length is reached
    while ($i < $length) {
        // Choose a random character from the possible ones
        $char = substr($possible, mt_rand(0, strlen($possible)-1), 1);
        // Don't want this character if it iss already in the password
        if (!strstr($password, $char)) {
            $password .= $char;
            $i++;
        }
    }
    return $password;
}

function generateToken($user) {
    // Generate a token for the logged in user
    $token = sha1($user.time().rand(0, 1000000));
    return $token;
}

function getClientIP() {
    if ($_SERVER['HTTP_CLIENT_IP'])
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    else if($_SERVER['HTTP_X_FORWARDED_FOR'])
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if($_SERVER['HTTP_X_FORWARDED'])
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if($_SERVER['HTTP_FORWARDED_FOR'])
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if($_SERVER['HTTP_FORWARDED'])
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if($_SERVER['REMOTE_ADDR'])
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    else
        $ipaddress = 'UNKNOWN';

    return $ipaddress;
}

function getTokenTimeout() {
    // Generate token timeout value
    $timeout = date('Y-m-d H:i:s', strtotime("+60 min"));
    return $timeout;
}

function isAlphaNumeric($str) {
    return !(preg_match('/[^A-Za-z0-9_]/', $str));
}

function isValidEmail($str){
    return (preg_match('/([\w\-]+\@[\w\-]+\.[\w\-]+)/',$str));
}

function isValidURL($str) {
    return (preg_match('/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i',$str));
}

function jsRedirectURL($url = "login.html") {
    // Preserve current page
    $_SESSION['destination_url'] = $_SERVER['REQUEST_URI'];

    // Redirect to given page using javascript
    echo('<script>');
    echo('window.location.replace("' . $url . '");');
    echo('</script>');
}

function passwordProtect($rank)
{
    // If user is not logged in and does not hold specified rank, redirect to login page
    if (!((isset($_SESSION['status']) && $_SESSION['status'] == 1) && (isset($_SESSION['rank']) && ($_SESSION['rank'] == $rank))))
        jsRedirectURL();
}

function passwordProtectRange($low_rank, $hi_rank)
{
    // If user is not logged in and does not hold specified rank range, redirect to login page
    if (!((isset($_SESSION['status']) && $_SESSION['status'] == 1) && (isset($_SESSION['rank']) && ($_SESSION['rank'] >= $low_rank && $_SESSION['rank'] <= $hi_rank ))))
        jsRedirectURL();
}

function rankToString($rank) {
    // Return a string interpretation of users rank
    switch($rank)
    {
        case -1:
            $str_rank = "No Access";
            break;
        case 0:
            $str_rank = "Public";
            break;
        case 1:
            $str_rank = "Student";
            break;
        case 2:
            $str_rank = "Instructor";
            break;
        case 3:
            $str_rank = "Administrator";
            break;
        default:
            $str_rank = "Invalid Rank";
    }
    return $str_rank;
}

function roundTwoDecimal($number)
{
    return number_format((float)$number, 2, '.', '');
}

function sendVerifToken($string)
{
    global $FORM_EMAIL_NO_REPLY;

    // Check for duplicate e-mail
    $query = "SELECT * FROM reg_users WHERE email='" . $string . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        $user_email = mysql_result($result, 0, "email");
        $tok = mysql_result($result, 0, "token");

        // Resend register success email
        $from = $FORM_EMAIL_NO_REPLY;
        $to = $user_email;
        $email_message = "-- Begin Message --\n\nYou are receiving this message because you registered an account at The C Pointer Tutor.\n\nYour email is: " . $user_email . " \n\nPlease follow the link below to verify your account and complete registration.\n\n http://c-pointer-its.net16.net/verify-email.php?vftok=" . $tok . ".\n\n  If you cannot select the link above then please copy and paste it into your browser address bar.\n\n-- End of Message --";
        $subject = "Welcome to The C Pointer Tutor";
        $headers = "From: " . $from;
        mail($to,$subject,$email_message,$headers);
    }
}

function userStatToString($stat) {
    // Return a string interpretation of user account status
    switch($stat)
    {
        case 'A':
            $str_stat = "Active";
            break;
        case 'X':
            $str_stat = "Banned";
            break;
        default:
            $str_stat = "Invalid Status";
    }
    return $str_stat;
}

function validateToken() {
    if ($_SESSION['token'] != '' || isset($_SESSION['token']) || !empty($_SESSION['token']))
    {
        require_once "../db/main_db_open.php";
        $query = "SELECT * FROM reg_users WHERE token='" . $_SESSION['token'] . "';";
        $result = mysql_query($query);

        // Check if the token is in the database
        if(mysql_numrows($result) != 1) {
            // If the token was not found, log the user out
            session_destroy();

            // Reset Session
            session_start();
            denyAccess();
            $_SESSION['message'] = 'Session error. Please log in again.';
        }
        else
        {
            // Check for found token timing out
            $token_timeout = mysql_result($result, 0, "token_validity");
            if ($token_timeout < date('Y-m-d H:i:s'))
            {
                // If the token has timed out, log the user out
                session_destroy();

                // Reset Session
                session_start();
                denyAccess();
                $_SESSION['message'] = 'Session timed out. Please log in again.';
            }
            // If token is valid and not timed out, fetch e-mail/rank and stay logged in
            else
            {
                $_SESSION['email'] = mysql_result($result, 0, "email");
                $_SESSION['rank'] = mysql_result($result, 0, "rank");
                $_SESSION['status'] = 1;

                // Extend token validity
                $query = "UPDATE reg_users SET token_validity='" . getTokenTimeout() . "' WHERE email='" . $_SESSION['email'] . "';";
                mysql_query($query);
            }
        }
        require_once "../db/main_db_close.php";
    }
}

?>