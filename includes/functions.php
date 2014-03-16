<?php
// Global variables
$FORM_EMAIL_ADMIN = "srbarney@asu.edu";
$FORM_EMAIL_NO_REPLY = "noreply@c-pointer-its.net16.net";
$MESSAGE_CHAR_MAX = 2500;

function clipString($string, $length = 10)
{
    $new_string = (strlen($string) > $length) ? substr($string,0,($length - 3)).'...' : $string;
    return $new_string;
}

function denyAccess() {
    $_SESSION['username'] = '';
    $_SESSION['status'] = 0;
    $_SESSION['rank'] = -1;
    unset($_SESSION['token']);
    unset($_SESSION['username']);
}

function formRedirectBack() {
    $http_ref = $_SERVER['HTTP_REFERER'];

    // If a referrer page is set go back to it
    if($http_ref)
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

function javaRedirectURL($url = "index.html") {
    // Redirect to given page using javascript
    echo('<script>');
    echo('window.location.replace("' . $url . '");');
    echo('</script>');
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

function resendVerifToken($user)
{
    global $FORM_EMAIL_NO_REPLY;

    // Open user database
    require "../db/main_db_open.php";

    // Check for duplicate username
    $query = "SELECT * FROM reg_users WHERE username='" . $user . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        $email = mysql_result($result, 0, "email");
        $tok = mysql_result($result, 0, "token");

        // Resend register success email
        $from = $FORM_EMAIL_NO_REPLY;
        $to = $email;
        $email_message = "-- Begin Message --\n\nYou are receiving this message because you registered an account at www.severtsonscreens.com.\n\nYour username is: " . $user . " \n\nPlease follow the link below to verify your account and complete registration.\n\n http://severtsonscreens.com/acct_verif.php?vftok=" . $tok . ".\n\n  If you cannot select the link above then please copy and paste it into your browser address bar.\n\n-- End of Message --";
        $subject = "Severtson Screens Registration";
        $headers = "From: " . $from;
        mail($to,$subject,$email_message,$headers);
    }

    // Close user database
    require "../db/main_db_close.php";
}

function roundTwoDecimal($number)
{
    return number_format((float)$number, 2, '.', '');
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
            // If token is valid and not timed out, fetch username/rank and stay logged in
            else
            {
                $_SESSION['username'] = mysql_result($result, 0, "username");
                $_SESSION['rank'] = mysql_result($result, 0, "rank");
                $_SESSION['status'] = 1;

                // Extend token validity
                $query = "UPDATE reg_users SET token_validity='" . getTokenTimeout() . "' WHERE username='" . $_SESSION['username'] . "';";
                mysql_query($query);
            }
        }
        require_once "../db/main_db_close.php";
    }
}

?>