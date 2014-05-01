<?php
// Start a session to store user data
if(!isset($_SESSION))
{
    session_start();
}

function arrayEqual($a, $b) {
    return (is_array($a) && is_array($b) && array_diff($a, $b) === array_diff($b, $a));
}

function attemptsToHTML($array)
{
    $html = '<script>$(document).ready(function() {$(".answer-area").hide();});</script><h1 class="white-text">REVIEW</h1>';

    foreach ($array as $question)
    {
        foreach ($question as $index=>$value)
        {
            if (isset($value['correct']) && !strcmp($value['correct'],'1'))
            {
                $src = __ROOT__ . "/icons/green-check-sm.png";
                $correct = "correct";
            }
            else
            {
                $src = __ROOT__ . "/icons/red-x-sm.png";
                $correct = "incorrect";
            }
            if(!strcmp($index,'qhtml'))
                $html .= '<br><br><h2 class="white-text">QUESTION</h2>' . $value;
            else if(!strcmp($index,'answer'))
                $html .= '<p class="white-text">Correct Answer: <span class="highlight">' . $value . '</span></p>';
            else
            {
                $html .= '<p class="white-text">Your Answer: <span class="' . $correct . '">' . $value['answer'] . '&nbsp;&nbsp;<img src="' . $src . '" style="margin:0;padding:0 3px 0 0;height:14px;"> ' . ucfirst($correct) . '</span></p>';
            }
        }
    }

    $html .= '<br><p><a href="select-task.php?lsn=' . getCurrentLessonID() . '"><button class="button">Retry Lesson</button></a>&nbsp;&nbsp;';
    $html .= '<a href="select-task.php"><button class="button">Next</button></a></p>';
    //$html .= '<form method="POST" action="select-task.php"><input class="button" type="submit" name="send" value="Next"></form></p>';

    return $html;
}

// Checks to see if the given array of tokens is a C or C++ style commented line
function cLineIsComment($array)
{
    $length = count($array);
    $first_two_char = substr($array[0], 0, 2);
    $last_two_char = substr($array[$length - 1], -2, 2);
    if(!strcmp($first_two_char, "/*") && !strcmp($last_two_char, "*/")) // Check for C style comments
        return true;
    else if(!strcmp($first_two_char, "//")) // Check for C++ style comments
        return true;
    return false;
}

// Check if the answer is correct by checking the question database
// Returns -1 if the provided task ID is not a question or is not found
// Otherwise returns 0 if incorrect and 1 if correct
function checkAnswer($id, $answer_string, $case_insensitive = 0)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the task database for the given ID
    //$query = "SELECT * FROM tasks WHERE id='" . $id . "';";
    //$result = mysql_query($query);
    //if(mysql_numrows($result) == 1)

    //$task_type = mysql_result($result, 0, "task_type");
    //$task_id = mysql_result($result, 0, "task_id");

    $task_id = getTaskID($id);
    $task_type = getTaskType($id);

    // If the task is founc and is a question
    if($task_id != 0 && !strcmp($task_type,'Q'))
    {
        $query = "SELECT * FROM questions WHERE id='" . $task_id . "';";
        $result = mysql_query($query);
        if(mysql_numrows($result) == 1)
        {
            // Collect and parse the database answer and the user's answer
            if ($case_insensitive == 0)
            {
                $correct_answer = parseCLine(htmlentities(mysql_result($result, 0, "answer")));
                $user_answer = parseCLine(htmlentities($answer_string));
            }
            else if ($case_insensitive == 1) // If the case insensitive flag is set, check the answer disregarding case
            {
                $correct_answer = parseCLine(strtoupper(htmlentities(mysql_result($result, 0, "answer"))));
                $user_answer = parseCLine(strtoupper(htmlentities($answer_string)));
            }

            // If the users answer matches the correct answer
            if (arrayEqual($user_answer, $correct_answer))
                return 1;
            else
                return 0;
        }
    }
    else
        return (-1);

    require __ROOT__ . "/db/main_db_close.php";
}

// Chooses the next task ID (currently just increments it by one)
function chooseNextTask($current_task_id, $override)
{
    // Set default increment
    $increment = 1;

    // If override is not set, then increment to the next task
    if ($override == 0)
    {
        $_SESSION['current_task']['ct_task_id'] = $current_task_id + $increment;

    }
}

// Explodes an array of functions by the given delimeter and keeps the delimeter in the array
function explodeArrayKeepDelimeter($delim, $tokens) {
    $array = array();
    foreach($tokens as $token)
    {
        $temp = explode($delim, $token, 20);
        $count = count($temp);
        if($count == 1)
            $array = array_merge((array)$array, (array)$temp);
        else
        {
            $temp2 = array();
            for($i = 0; $i < count($temp); $i++)
            {
                if($count >= 2)
                {
                    $temp2 = array_merge($temp2, (array)$temp[$i], (array)$delim, (array)$temp[$i+1]);
                    $count--;
                }
            }
            $array = array_values(array_filter(array_merge((array)$array, (array)$temp2)));
        }
    }
    return $array;
}

// Explodes the apostrophe in the given array and sets error flags
function explodePointer($array)
{
    $temp_array = array();
    $no_apost_flag = 1; // Set to 1 if no apostrophe is found
    $no_ptr_flag = 1; // Set to 1 if no valid pointer is found
    foreach($array as $token)
    {
        // Check the whole token for an apostrophe
        if(strpos($token, '*') !== FALSE)
        {
            $no_apost_flag = 0;
        }
        $first_char = substr($token, 0, 1);
        $last_char = substr($token, -1, 1);
        if((strcmp($first_char, '*') == 0) && strlen($token) == 1) // If an apostrophe is floating EX: int * ptr
        {
            $temp_array = array_merge($temp_array, (array)$token);
            $no_ptr_flag = 0;
        }
        else if((strcmp($first_char, '*') == 0) && strlen($token) > 1) // If an apostrophe is found at the beginning of a token EX: int *ptr
        {
            $temp_array = array_merge($temp_array, (array)'*', (array)substr($token, 1));
            $no_ptr_flag = 0;
        }
        else if((strcmp($last_char, '*') == 0) && strlen($token) > 1) // If an apostrophe is found at the end of a token EX: int* ptr
        {
            $temp_array = array_merge($temp_array, (array)substr($token, 0, -1), (array)'*');
            $no_ptr_flag = 0;
        }
        else // Else just add the token to the array
            $temp_array = array_merge($temp_array, (array)$token);
    }
    $temp_array = array_values(array_filter($temp_array));
    $_SESSION['C_LINE_ERR']['NO_APOST'] = $no_apost_flag;
    $_SESSION['C_LINE_ERR']['NO_PTR'] = $no_ptr_flag;
    return $temp_array;
}

function generateTaskList()
{
    // CONSTANTS THAT CAN BE CHANGED
    $QUESTIONS_PER_SECTION = 4;
    $NUMBER_OF_LESSONS = 1;

    // COUNTERS -- do not change
    $id = 1;
    $l_task_id = 1;
    $a_task_id = 1;

    $array = array();

    // Outer loop generates lesson block, inner loops generate question blocks
    for($j = 0; $j < $NUMBER_OF_LESSONS; $j++)
    {
        // Output lesson task
        $array[$id] = '"task' . $id . '": {"id": ' . $id . ',"type": "L","taskid": ' . $l_task_id . '}';
        $id++;

        // Get an array of random question IDs
        $q_ids = generateRandomQIDArray($QUESTIONS_PER_SECTION, $l_task_id, false);

        // Output the first section of questions for each unit
        for($i = 0; $i < $QUESTIONS_PER_SECTION; $i++)
        {
            $array[$id] = '"task' . $id . '": {"id": ' . $id . ',"type": "Q","taskid": ' . $q_ids[$i] . '}';
            $id++;
        }
        // Output assessment task
        $array[$id] = '"task' . $id . '": {"id": ' . $id . ',"type": "A","taskid": ' . $a_task_id . '}';
        $a_task_id++;
        $id++;

        // Get an array of random question IDs
        $q_ids = generateRandomQIDArray($QUESTIONS_PER_SECTION, $l_task_id, true);

        // Output the second set of questions for each unit
        for($i = 0; $i < $QUESTIONS_PER_SECTION; $i++)
        {
            $array[$id] = '"task' . $id . '": {"id": ' . $id . ',"type": "Q","taskid": ' . $q_ids[$i] . '}';
            $id++;
        }
        // Output assessment task
        $array[$id] = '"task' . $id . '": {"id": ' . $id . ',"type": "A","taskid": ' . $a_task_id . '}';
        $a_task_id++;
        $id++;

        // Increment lesson number
        $l_task_id++;
    }

    $string = '{' . implode(',', $array) . '}';

    return $string;
}

function generateRandomQIDArray($length, $lesson, $cumulative = false)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Check if the question ID array is cumulative or not
    if ($cumulative)
        $query = "SELECT * FROM `questions` WHERE `lesson_tag`<='" . $lesson . "';";
    else
        $query = "SELECT * FROM `questions` WHERE `lesson_tag`='" . $lesson . "';";

    $result = mysql_query($query);
    $numquestions = mysql_numrows($result);

    // Build the full question array
    $array = array();
    for($i = 0; $i < $numquestions; $i++)
    {
        $array[$i] = mysql_result($result, $i, "id");
    }

    require __ROOT__ . "/db/main_db_close.php";

    // Build the random question ID array
    $i = 0;
    $random_id_array = array();
    while($i < $length)
    {
        $temp = rand(0, $numquestions - 1); // $temp is the accessor for $array
        if (!in_array($array[$temp], $random_id_array, true))
        {
            $random_id_array[$i] = $array[$temp];
            $i++;
        }
    }

    return $random_id_array;
}

// Returns the Lesson ID based on the current task
function getCurrentLessonID()
{
    //Default lesson ID
    $lesson_id = 1;
    $current_task = $_SESSION['current_task']['ct_task_id'];
    $task_reached = false;

    foreach(json_decode($_SESSION['json_task_list']) as $task)
    {
        if($task->id == $current_task)
            $task_reached = true;

        // Iterate through lessons while current task is not reached
        if($task_reached == false && !strcmp($task->type,"L"))
            $lesson_id = $task->taskid;
    }
    return $lesson_id;
}

function getMasteryLevels($id=0)
{
    require __ROOT__ . "/db/main_db_open.php";

    // If ID == 0 select all, otherwise select only the given ID
    if ($id > 0)
        $query = "SELECT * FROM `user_profile` WHERE `user_id`='" . $id . "';";
    else if ($id == 0) // If ID == 0 select all users from the database
        $query = "SELECT * FROM `user_profile`";

    $data = array();
    $result = mysql_query($query);
    $numusers = mysql_numrows($result);
    for($i = 0; $i < $numusers; $i++)
    {
        // Calculate all the KC mastery percentages
        if (mysql_result($result, $i, "KC1attempts") != 0)
            $kc01mastery = roundTwoDecimal(100 * mysql_result($result, $i, "KC1correct") / mysql_result($result, $i, "KC1attempts"));
        else
            $kc01mastery = 0;

        if (mysql_result($result, $i, "KC2attempts") != 0)
            $kc02mastery = roundTwoDecimal(100 * mysql_result($result, $i, "KC2correct") / mysql_result($result, $i, "KC2attempts"));
        else
            $kc02mastery = 0;

        if (mysql_result($result, $i, "KC3attempts") != 0)
            $kc03mastery = roundTwoDecimal(100 * mysql_result($result, $i, "KC3correct") / mysql_result($result, $i, "KC3attempts"));
        else
            $kc03mastery = 0;

        if (mysql_result($result, $i, "KC4attempts") != 0)
            $kc04mastery = roundTwoDecimal(100 * mysql_result($result, $i, "KC4correct") / mysql_result($result, $i, "KC4attempts"));
        else
            $kc04mastery = 0;

        // Create user array
        $array = array(
            'id' => mysql_result($result, $i, "user_id"),
            'scores' => array($kc01mastery, $kc02mastery, $kc03mastery, $kc04mastery)
        );

        // Add user array to data array
        $data[$i] = $array;
    }

    require __ROOT__ . "/db/main_db_close.php";

    return $data;
}

function getLessonTaskID($id)
{
    //Default lesson ID -- error
    $task_id = 0;

    foreach(json_decode($_SESSION['json_task_list']) as $task)
    {
        if($task->taskid == $id && !strcmp($task->type,"L"))
            $task_id = $task->id;
    }
    return $task_id;
}

function getTaskID($id)
{
    //Default task ID -- error
    $task_id = 0;

    foreach(json_decode($_SESSION['json_task_list']) as $task)
    {
        if($task->id == $id)
            $task_id = $task->taskid;
    }
    return $task_id;
}

function getTaskType($id)
{
    //Default task ID -- error
    $task_type = 'X';

    foreach(json_decode($_SESSION['json_task_list']) as $task)
    {
        if($task->id == $id)
            $task_type = $task->type;
    }
    return $task_type;
}

function getUnreviewedAttempts($user_id)
{
    require __ROOT__ . "/db/main_db_open.php";

    $query = "SELECT * FROM `task_attempts` WHERE `student_id`='" . $user_id . "' AND `reviewed`='0' ORDER BY id ASC;";
    $result = mysql_query($query);
    $num_attempts = mysql_numrows($result);
    $attempt = array();

    if ($num_attempts == 0)
        $attempt = array(0 => array('qhtml' => "<p class='white-text'>Nothing to Display</p>"));
    else
    {
        // Capture all unreviewed attempts
        for($i = 0; $i < $num_attempts; $i++)
        {
            $qid = mysql_result($result, $i, "question_id");
            $user_answer = mysql_result($result, $i, "user_answer");
            $correct = mysql_result($result, $i, "correct");

            // Get the question HTML
            $query = "SELECT * FROM `questions` WHERE `id`='" . $qid . "';";
            $qresult = mysql_query($query);

            if(mysql_numrows($qresult) == 1)
            {
                $attempt[$qid]['qhtml'] = mysql_result($qresult, 0, "question");
                $attempt[$qid]['answer'] = mysql_result($qresult, 0, "answer");
            }

            $attempt[$qid][$i]['answer'] = $user_answer;
            $attempt[$qid][$i]['correct'] = $correct;
        }
    }

    require __ROOT__ . "/db/main_db_close.php";

    return $attempt;
}

function hashArray ($array)
{
    return md5(serialize($array));
}

// Outputs a JQuery initialization of the HighChart when called, data can be passed into this function from the SQL database
function initializeHighChart($data="", $categories=array('Syntax', 'Basic Theory', 'Advanced Theory', 'Applications'), $type="column", $title="Student Mastery Levels", $subtitle="Percentages", $unit="percent")
{
    echo("<script>");
    echo("$(document).ready(function() {");
    echo("$('#chart').highcharts({");
    echo("chart: {");
    echo("type: '" . $type . "'");
    echo("},");
    echo("title: {");
    echo("text: '" . $title . "'");
    echo("},");
    echo("subtitle: {");
    echo("text: '(" . $subtitle . ")'");
    echo("},");
    echo("xAxis: {");
    echo("categories: ");
    echo("['". implode("', '", $categories) . "'],");
    echo("title: {");
    echo("text: null");
    echo("}");
    echo("},");
    echo("yAxis: {");
    echo("min: 0,");
    echo("title: {");
    echo("text: 'Mastery (" . $unit . ")',");
    echo("align: 'high'");
    echo("},");
    echo("labels: {");
    echo("overflow: 'justify'");
    echo("}");
    echo("},");
    echo("tooltip: {");
    echo("valueSuffix: ' " . $unit . "'");
    echo("},");
    echo("plotOptions: {");
    echo("bar: {");
    echo("dataLabels: {");
    echo("enabled: true");
    echo("}");
    echo("}");
    echo("},");
    echo("legend: {");
    echo("layout: 'vertical',");
    echo("align: 'right',");
    echo("verticalAlign: 'top',");
    echo("x: -40,");
    echo("y: 100,");
    echo("floating: true,");
    echo("borderWidth: 1,");
    echo("backgroundColor: '#FFFFFF',");
    echo("shadow: true");
    echo("},");
    echo("credits: {");
    echo("enabled: false");
    echo("},");
    echo("series: [{");

    // Output the data
    $i = count($data);
    foreach ($data as $learner)
    {
        echo("name: 'User " . $learner['id'] . "',");
        echo("data: [". implode(", ", $learner['scores']) . "]");
        if(--$i) // While still has another user
            echo("}, {");
    }
    echo("}]");
    echo("});");
    echo("});");
    echo("</script>");
}

// Get task information with given ID and store it into the $_SESSION
function loadTask($id)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the task database for the given ID
    //$query = "SELECT * FROM tasks WHERE id='" . $id . "';";
    //$result = mysql_query($query);
    //if(mysql_numrows($result) == 1)
    //{
    //$task_type = mysql_result($result, 0, "task_type");
    //$task_id = mysql_result($result, 0, "task_id");

    $task_id = getTaskID($id);
    $task_type = getTaskType($id);

    // Depending on which task type it is, get the data from the database
    switch($task_type)
    {
        case "Q":
            $query = "SELECT * FROM questions WHERE id='" . $task_id . "';";
            $result = mysql_query($query);
            if(mysql_numrows($result) == 1)
            {
                $_SESSION['current_task']['ct_html'] = '<h2 class="white-text">QUESTION</h2>'. mysql_result($result, 0, "question"); // Store question HTML
                $_SESSION['current_task']['ct_kc'] = mysql_result($result, 0, "kc"); // Store question knowledge component ID
                $_SESSION['current_task']['ct_atype'] = mysql_result($result, 0, "answer_type"); // Store answer type
            }
            break;
        case "L":
            $query = "SELECT * FROM lessons WHERE id='" . $task_id . "';";
            $result = mysql_query($query);
            if(mysql_numrows($result) == 1)
            {
                $_SESSION['current_task']['ct_html'] = mysql_result($result, 0, "html");
                if(isset($answer)) unset($answer);
            }
            break;
        case "A":
            $_SESSION['current_task']['ct_html'] = attemptsToHTML(getUnreviewedAttempts($_SESSION['userid'])); // Prep assessment HTML
            $_SESSION['current_task']['ct_reviewed_flag'] = 1; // Set flag to indicate that attempts are being reviewed
            break;
    }
    //}
    require __ROOT__ . "/db/main_db_close.php";
}

function loadTaskList($user_id)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the reg_users database for the given ID
    $query = "SELECT * FROM `reg_users` WHERE id='" . $user_id . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        $_SESSION['json_task_list'] = mysql_result($result, 0, "task_list");
    }

    require __ROOT__ . "/db/main_db_close.php";
}

function logAttempt($user_id, $task_id, $user_answer, $correct)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the task database for the given ID
    //$query = "SELECT * FROM tasks WHERE id='" . $task_id . "' AND task_type='Q';";
    //$result = mysql_query($query);
    //if(mysql_numrows($result) == 1)
    //{
        // Get the question ID
        //$question_id = mysql_result($result, 0, "task_id");

        $question_id = getTaskID($task_id);

        // Insert the attempt into the database
        mysql_query("INSERT INTO task_attempts(question_id, student_id, user_answer, correct) VALUES ('$question_id','$user_id', '$user_answer', '$correct')") or die("".mysql_error());
    //}

    require __ROOT__ . "/db/main_db_close.php";
}

// Main parsing function: takes a string and drives all of the necessary functions to output an array of tokens with error flags
function parseCLine($str)
{
    $_SESSION['C_LINE_ERR'] = array(
        "NO_APOST" => 'X',
        "NO_PTR" => 'X',
        "COMMENTED" => 'X',
        "NO_SEMI_COLON" => 'X'
    );

    // Clear whitespace before and after string
    $str = trim($str);

    $tokens = explode(' ', $str, 20);
    if(!cLineIsComment($tokens))
    {
        $_SESSION['C_LINE_ERR']['COMMENTED'] = 0;

        // Check if the last character is a semi-colon
        if(!strcmp(substr($str, -1, 1), ';'))
            $_SESSION['C_LINE_ERR']['NO_SEMI_COLON'] = 0;
        else
            $_SESSION['C_LINE_ERR']['NO_SEMI_COLON'] = 1;

        $array = explodeArrayKeepDelimeter('(',$tokens);
        $array = explodeArrayKeepDelimeter(')',$array);
        $array = explodeArrayKeepDelimeter(',',$array);
        $array = explodeArrayKeepDelimeter(';',$array);
        $array = explodePointer($array); // Lame way to test for up to a triple pointer, but it works
        $array = explodePointer($array);
        $array = explodePointer($array);
    }
    else
    {
        $array = array('The C line is commented out');
        $_SESSION['C_LINE_ERR']['COMMENTED'] = 1;
    }
    return $array;
}

// Outputs to HTML page the given C Line array including any $_SESSION C line errors
function printCLine($array)
{
    // Print each token in the C Line
    foreach($array as $token)
    {
        echo("\"" . $token . "\" ");
    }

    // Print all the error flags stored in session
    foreach($_SESSION['C_LINE_ERR'] as $error=>$value)
    {
        echo ($error . ': ' . $value . ' ');
    }
    echo('<br>');
}

// Stores the given task ID into the specified users profile in reg_users database
function saveTaskID($user_id, $task_id)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the reg_users database for the given ID
    $query = "SELECT * FROM `reg_users` WHERE id='" . $user_id . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        mysql_query("UPDATE `reg_users` SET current_task='" . $task_id . "' WHERE id='" . $user_id . "';");
    }

    require __ROOT__ . "/db/main_db_close.php";
}

function setReviewedAttempts($user_id)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Mark attempts as reviewed
    $query = "UPDATE `task_attempts` SET reviewed='1' WHERE `student_id`='" . $user_id . "' AND `reviewed`='0';";
    mysql_query($query);

    require __ROOT__ . "/db/main_db_close.php";
}

function storeTaskList($user_id, $list)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the reg_users database for the given ID
    $query = "SELECT * FROM `reg_users` WHERE id='" . $user_id . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        mysql_query("UPDATE `reg_users` SET `task_list`='" . $list . "' WHERE id='" . $user_id . "';");
    }

    require __ROOT__ . "/db/main_db_close.php";
}

// Updates the learner model in the database
function updateUserProfile($user_id, $kc_id, $correct)
{
    // Retry flag is used to specify whether or not the user can retry the question without being penalized
    $retry_flag = 0;

    // Prepare error message
    if(!isset($_SESSION['message']))
    {
        $_SESSION['message'] == '';
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // THIS BLOCK OF CODE TRIES TO DETECT SIMPLE MISTAKES MADE BY THE USER AND ALLOWS THEM TO RETRY WITHOUT PENALTY //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Check if the answer was left blank
    if(isset($_SESSION['current_task']['ct_user_answer']) && strlen($_SESSION['current_task']['ct_user_answer']) == 0)
    {
        $_SESSION['message'] .= 'Please enter an answer in the textbox, then click "Submit". ';
        $retry_flag = 1;
    }
    else if (isset($_SESSION['current_task']['ct_correct']) && $_SESSION['current_task']['ct_correct'] == 0 && isset($_SESSION['current_task']['ct_correct_ci']) && $_SESSION['current_task']['ct_correct_ci'] == 1)
    {
        // Display message if the answer has the incorrect case
        $_SESSION['message'] .= 'Your answer is nearly correct -- the answers are case-sensitive, so check your upper and lowercase characters and try again. ';
        $retry_flag = 1;
    }
    else
    {
        // Check if the answer is expected to be a line of code 'C' or text 'T'
        if(isset($_SESSION['current_task']['ct_atype']) && !strcmp($_SESSION['current_task']['ct_atype'],'C'))
        {
            // Check if the answer was incorrect, then we will see if they get a second chance for a simple mistake
            if(isset($_SESSION['current_task']['ct_correct']) && $_SESSION['current_task']['ct_correct'] == 0)
            {
                // Check for missing semi-colon at the end of the line
                if(isset($_SESSION['C_LINE_ERR']['NO_SEMI_COLON']) && $_SESSION['C_LINE_ERR']['NO_SEMI_COLON'] == 1)
                {
                    $_SESSION['message'] .= 'Did you forget to put a semi-colon at the end of your line of code? ';
                    $retry_flag = 1;
                }
                // Check if the line was commented out
                if(isset($_SESSION['C_LINE_ERR']['COMMENTED']) && $_SESSION['C_LINE_ERR']['COMMENTED'] == 1)
                {
                    $_SESSION['message'] .= 'The line you entered is a comment. Remove comment characters and try again. ';
                    $retry_flag = 1;
                }
            }
        }
        else if (isset($_SESSION['current_task']['ct_atype']) && !strcmp($_SESSION['current_task']['ct_atype'],'T'))
        {
            // Check if the answer was incorrect, then we will see if they get a second chance for a simple mistake
            if(isset($_SESSION['current_task']['ct_correct']) && $_SESSION['current_task']['ct_correct'] == 0)
            {
                // Check for added semi-colon at the end of the line
                if(isset($_SESSION['C_LINE_ERR']['NO_SEMI_COLON']) && $_SESSION['C_LINE_ERR']['NO_SEMI_COLON'] == 0)
                {
                    $_SESSION['message'] .= 'The answer is not a line of code, so no semi-colon is needed. Read the question carefully and try again. ';
                    $retry_flag = 1;
                }
            }
        }
    }

    // If the retry flag is not set, then log the answer
    if ($retry_flag == 0)
    {
        require __ROOT__ . "/db/main_db_open.php";

        // Search the user_profile database for the given ID
        $query = "SELECT * FROM `user_profile` WHERE user_id='" . $user_id . "';";
        $result = mysql_query($query);

        // Create a new user profile with given ID
        if(mysql_numrows($result) != 1)
        {
            mysql_query("INSERT INTO user_profile(user_id, KC1correct, KC1attempts, KC2correct, KC2attempts, KC3correct, KC3attempts, KC4correct, KC4attempts) VALUES ('$user_id','0','0','0','0','0','0','0','0')") or die("".mysql_error());

            // Store the user profile in $result
            $query = "SELECT * FROM `user_profile` WHERE user_id='" . $user_id . "';";
            $result = mysql_query($query);
        }

        // Update current profile according to which knowledge component is tested
        switch($kc_id)
        {
            case 0:
                $num_correct = mysql_result($result, 0, "KC1correct");
                $num_attempts = mysql_result($result, 0, "KC1attempts");
                mysql_query("UPDATE `user_profile` SET KC1correct='" . ($num_correct + $correct) . "' WHERE user_id='" . $user_id . "';");
                mysql_query("UPDATE `user_profile` SET KC1attempts='" . ($num_attempts + 1) . "' WHERE user_id='" . $user_id . "';");
                break;
            case 1:
                $num_correct = mysql_result($result, 0, "KC2correct");
                $num_attempts = mysql_result($result, 0, "KC2attempts");
                mysql_query("UPDATE `user_profile` SET KC2correct='" . ($num_correct + $correct) . "' WHERE user_id='" . $user_id . "';");
                mysql_query("UPDATE `user_profile` SET KC2attempts='" . ($num_attempts + 1) . "' WHERE user_id='" . $user_id . "';");
                break;
            case 2:
                $num_correct = mysql_result($result, 0, "KC3correct");
                $num_attempts = mysql_result($result, 0, "KC3attempts");
                mysql_query("UPDATE `user_profile` SET KC3correct='" . ($num_correct + $correct) . "' WHERE user_id='" . $user_id . "';");
                mysql_query("UPDATE `user_profile` SET KC3attempts='" . ($num_attempts + 1) . "' WHERE user_id='" . $user_id . "';");
                break;
            case 3:
                $num_correct = mysql_result($result, 0, "KC4correct");
                $num_attempts = mysql_result($result, 0, "KC4attempts");
                mysql_query("UPDATE `user_profile` SET KC4correct='" . ($num_correct + $correct) . "' WHERE user_id='" . $user_id . "';");
                mysql_query("UPDATE `user_profile` SET KC4attempts='" . ($num_attempts + 1) . "' WHERE user_id='" . $user_id . "';");
                break;
        }

        require __ROOT__ . "/db/main_db_close.php";
    }
    return $retry_flag;
}

?>