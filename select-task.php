<?php
    // SELECT-TASK.PHP - Handles selecting a task for the user to do
    require_once "includes/functions.php";
    require_once "includes/its-functions.php";

    // Start a session to store user data
    session_start();

    // Do some stuff to figure out what to select

    // Get the HTML for the task from the Database

    // Store the HTML in the $_SESSION['current_task']
    $_SESSION['current_task'] = '<h1 class="white-text">DUMMY TASK - NEED TO REPLACE THIS</h1>';

    // Redirect browser
    formRedirectBack();
    exit;
?>