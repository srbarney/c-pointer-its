<?php
    // SELECT-TASK.PHP - Handles selecting a task for the user to do
    require_once "includes/constants.php";
    require_once "includes/functions.php";
    require_once "includes/its-functions.php";

    // Start a session to store user data
    if(!isset($_SESSION))
    {
        session_start();
    }

    // Force the user data and question data to be refreshed from the database
    validateToken();

    //print_r($_SESSION['current_task']);

    // Check answer correctness
    if(isset($_POST['answer']))
    {
        // Check if the answer is correct
        $_SESSION['current_task']['ct_correct'] = checkAnswer($_SESSION['current_task']['ct_task_id'], htmlspecialchars($_POST['answer']));
        unset($_POST['answer']);

        // Update learner model database
        if($_SESSION['current_task']['ct_correct'] == 0 || $_SESSION['current_task']['ct_correct'] == 1)
            updateUserProfile($_SESSION['userid'], $_SESSION['current_task']['ct_kc'], $_SESSION['current_task']['ct_correct']);
        else
            $_SESSION['message'] = "Error: Question ID not found.";
    }

    // Choose the next task
    chooseNextTask($_SESSION['current_task']['ct_task_id']);

    // Get the HTML for the task from the Database
    loadTask($_SESSION['current_task']['ct_task_id']);

    //print_r($_SESSION['current_task']);

    // Save current task in the user database
    saveTaskID($_SESSION['userid'], $_SESSION['current_task']['ct_task_id']);

    // Redirect browser
    formRedirectBack();
    exit;
?>