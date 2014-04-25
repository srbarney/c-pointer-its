<?php
// CHECK_ANSWER.PHP - Checks if example answer is correct
require_once "includes/its-functions.php";

// Check if form was sent
if(isset($_POST['answer']))
{
    $answer = htmlspecialchars($_POST["answer"]);
    $hash = htmlspecialchars($_POST["hash"]);

    $answer = hashArray(parseCLine($answer));

    if(!strcmp($answer, $hash))
        $output = '1';
    else
        $output = '0';
}
else
    $output = '-1';

// Send back the html message
echo($output);
?>