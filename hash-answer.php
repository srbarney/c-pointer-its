<?php
// HASH_ANSWER.PHP - Returns the hash of an answer string to the calling JS script
require_once "includes/its-functions.php";

if(isset($_POST['answer']))
{
    $answer = htmlspecialchars($_POST["answer"]);
    echo(hashArray(parseCLine($answer)));
}
else
    echo('X');
?>