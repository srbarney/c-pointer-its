<?php
    // LOGOUT.PHP - Handles user logout
    require_once "includes/functions.php";

    // Start a session to store user data
    session_start();

    // Destroy session
    session_destroy();

    // Reset Session
    session_start();
    denyAccess();
    $_SESSION['message'] = 'Logout successful.';

    // Redirect browser
    formRedirectBack();
    exit;
?>