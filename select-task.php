<?php
    // SELECT-TASK.PHP - Handles selecting a task for the user to do
    require_once "includes/functions.php";
    require_once "includes/its-functions.php";

    // Start a session to store user data
    session_start();

    // If the current task ID is not set, set it to 1
    if(!isset($_SESSION['current_task']['ct_task_id']))
    {
        $_SESSION['current_task']['ct_task_id'] = 1;
    }
    else
    {
        // Increment to the next task
        $_SESSION['current_task']['ct_task_id'] += 1;
    }

    // Get the HTML for the task from the Database
    loadTaskHTML($_SESSION['current_task']['ct_task_id']);

    // Redirect browser
    formRedirectBack();
    exit;
?>