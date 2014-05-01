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

    // Check if the lesson select is set
    if(isset($_GET['lsn']))
    {
        // For now restart from the first task
        $lesson_id = getLessonTaskID(isset($_GET['lsn']));
        if ($lesson_id > 0)
            saveTaskID($_SESSION['userid'], $lesson_id - 1);
        else
            saveTaskID($_SESSION['userid'], 0);
        unset($_GET['lsn']);
    }

    // Force the user data and question data to be refreshed from the database
    validateToken();

    // If reviewed flag is set, mark the attempts as reviewed in the database
    if(isset($_SESSION['current_task']['ct_reviewed_flag']) && $_SESSION['current_task']['ct_reviewed_flag'] == 1)
    {
        setReviewedAttempts($_SESSION['userid']);
        unset($_SESSION['current_task']['ct_reviewed_flag']);
    }

    $retry_flag = 0;

    // Check answer correctness
    if(isset($_POST['answer']))
    {
        // Get answer string
        $_SESSION['current_task']['ct_user_answer'] = htmlspecialchars($_POST['answer']);
        unset($_POST['answer']);

        // Check if the answer is correct (1), incorrect (0), or not found (-1)
        $_SESSION['current_task']['ct_correct_ci'] = checkAnswer($_SESSION['current_task']['ct_task_id'], $_SESSION['current_task']['ct_user_answer'], 1);
        $_SESSION['current_task']['ct_correct'] = checkAnswer($_SESSION['current_task']['ct_task_id'], $_SESSION['current_task']['ct_user_answer']);

        // Update learner model database
        if($_SESSION['current_task']['ct_correct'] == 0 || $_SESSION['current_task']['ct_correct'] == 1)
        {
            $retry_flag = updateUserProfile($_SESSION['userid'], $_SESSION['current_task']['ct_kc'], $_SESSION['current_task']['ct_correct']);
            logAttempt($_SESSION['userid'], $_SESSION['current_task']['ct_task_id'], $_SESSION['current_task']['ct_user_answer'], $_SESSION['current_task']['ct_correct']);
        }
        else
            $_SESSION['message'] = "Error: Question ID not found.";
    }

    // Choose the next task
    chooseNextTask($_SESSION['current_task']['ct_task_id'], $retry_flag);

    // Get the HTML for the task from the Database
    loadTask($_SESSION['current_task']['ct_task_id']);

    // Save current task in the user database
    saveTaskID($_SESSION['userid'], $_SESSION['current_task']['ct_task_id']);

    // Redirect browser
    formRedirectBack();
    exit;
?>