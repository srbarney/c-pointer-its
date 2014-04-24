<?php
    // Start a session to store user data
    if(!isset($_SESSION))
    {
        session_start();
    }

    require_once "includes/constants.php";
    require_once "includes/functions.php";
    require_once "includes/its-functions.php";

    validateToken();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>C Pointer Tutoring System</title>
<meta name="keywords" content="c pointer tutoring system">
<meta name="description" content="C Pointer Tutoring System">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">

<!--  Force IE to use the latest version of its rendering engine -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet" type="text/css" href="css/dashboard.css">
<link rel="stylesheet" type="text/css" href="css/forms.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/navigation.css">
<link rel="stylesheet" type="text/css" href="css/jquery.powertip.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="js/functions.js"></script>
<script type="text/javascript" src="js/highcharts/highcharts.js"></script>
<script type="text/javascript" src="js/highcharts/modules/exporting.js"></script>
<script type="text/javascript" src="js/jquery.backstretch.min.js"></script>
<script type="text/javascript" src="js/jquery.powertip.min.js"></script>
<script type="text/javascript" src="js/jquery.sticky.js"></script>
<script type="text/javascript" src="js/nav-menu-init.js"></script>

</head>