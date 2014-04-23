<?php
// Start a session to store user data
if(!isset($_SESSION))
{
    session_start();
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
function loadTaskHTML($id)
{
    require "db/main_db_open.php";

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
                    $_SESSION['current_task']['ct_html'] = mysql_result($result, 0, "question");
                    $_SESSION['current_task']['ct_answer'] = mysql_result($result, 0, "answer");
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


    require "db/main_db_close.php";
}

// Main parsing function: takes a string and drives all of the necessary functions to output an array of tokens with error flags
function parseCLine($str)
{
    $_SESSION['C_LINE_ERR'] = array(
        "NO_APOST" => 'X',
        "NO_PTR" => 'X',
        "COMMENTED" => 'X'
    );

    $tokens = explode(' ', $str, 20);
    if(!cLineIsComment($tokens))
    {
        $_SESSION['C_LINE_ERR']['COMMENTED'] = 0;
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