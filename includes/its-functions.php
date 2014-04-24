<?php
// Start a session to store user data
if(!isset($_SESSION))
{
    session_start();
}

function arrayEqual($a, $b) {
    return (is_array($a) && is_array($b) && array_diff($a, $b) === array_diff($b, $a));
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
function checkAnswer($id, $answer_string)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the task database for the given ID
    $query = "SELECT * FROM tasks WHERE id='" . $id . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        $task_type = mysql_result($result, 0, "task_type");
        $task_id = mysql_result($result, 0, "task_id");

        // If the task is a question
        if(!strcmp($task_type,'Q'))
        {
            $query = "SELECT * FROM questions WHERE id='" . $task_id . "';";
            $result = mysql_query($query);
            if(mysql_numrows($result) == 1)
            {
                // Collect and parse the database answer and the user's answer
                $correct_answer = parseCLine(mysql_result($result, 0, "answer"));
                $user_answer = parseCLine($answer_string);

                // If the users answer matches the correct answer
                if (arrayEqual($user_answer, $correct_answer))
                    return 1;
                else
                    return 0;
            }
        }
        else
            return (-1);
    }
    else
        return (-1);

    require __ROOT__ . "/db/main_db_close.php";
}

// Chooses the next task ID (currently just increments it by one)
function chooseNextTask($current_task_id)
{
    // Prepare error message
    if(!isset($_SESSION['message']))
    {
        $_SESSION['message'] == '';
    }

    // Go through C_LINE_ERR array to determine if error messages should be displayed
    // Check for no semi-colon -- NEED TO KNOW IF THE ANSWER IS CODE OR NOT BEFORE CHECKING
    if(isset($_SESSION['current_task']['ct_correct']) && $_SESSION['current_task']['ct_correct'] == 0)
    {
        if(isset($_SESSION['C_LINE_ERR']['NO_SEMI_COLON']) && $_SESSION['C_LINE_ERR']['NO_SEMI_COLON'] == 1)
        {
            $_SESSION['message'] .= 'Did you forget to put a semi-colon at the end of your line of code?';
        }
    }
    else
    {
        $_SESSION['current_task']['ct_task_id'] = $current_task_id + 1;
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

// Get task information with given ID and store it into the $_SESSION
function loadTask($id)
{
    require __ROOT__ . "/db/main_db_open.php";

    // Search the task database for the given ID
    $query = "SELECT * FROM tasks WHERE id='" . $id . "';";
    $result = mysql_query($query);
    if(mysql_numrows($result) == 1)
    {
        $task_type = mysql_result($result, 0, "task_type");
        $task_id = mysql_result($result, 0, "task_id");

        // Depending on which task type it is, get the data from the database
        switch($task_type)
        {
            case "Q":
                $query = "SELECT * FROM questions WHERE id='" . $task_id . "';";
                $result = mysql_query($query);
                if(mysql_numrows($result) == 1)
                {
                    $_SESSION['current_task']['ct_html'] = mysql_result($result, 0, "question"); // Store question HTML
                    $_SESSION['current_task']['ct_kc'] = mysql_result($result, 0, "kc"); // Store question knowledge component ID
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
        }
    }


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

// Updates the learner model in the database
function updateUserProfile($user_id, $kc_id, $correct)
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

// Outputs a JQuery initialization of the HighChart when called, data can be passed into this function from the SQL database
function initializeHighChart($data, $categories=array('KC1','KC2','KC3','KC4'), $type="column", $title="Student Mastery Levels", $subtitle="Percentages", $unit="percent")
{
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

    // Iterate through all categories
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
    echo("name: 'Student 01',");
    echo("data: [0.78, 0.8, 0.6, 0.2, 0]");
    echo("}, {");
    echo("name: 'Student 02',");
    echo("data: [0.9, 0.83, 0.4, 0.65, 0]");
    echo("}, {");
    echo("name: 'Student 03',");
    echo("data: [0.77, 0.86, 0.51, 0.23, 0.75]");
    echo("}]");
    echo("});");
    echo("});");
}

?>