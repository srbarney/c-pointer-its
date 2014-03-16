<?php
    // MAIN_DB_OPEN - Opens a connection to the main database
    require "main_db_credentials.php";

    $main_link = mysql_connect($db_host, $db_user, $db_pass);
    mysql_select_db($db_name, $main_link);
?>