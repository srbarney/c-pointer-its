<?php require_once "nav-menu.php"; ?>
<div id="master-header">
    <a class="menu-link"><img src="/icons/menu-button.png" alt="MENU"/></a>
    <h1 class="main-title">C Pointer Tutoring System</h1>
    <?php
        if (isset($_SESSION['status']) && $_SESSION['status'] == 1)
        {
            echo('<p class="menu-account-info">Welcome, ' . $_SESSION["firstname"] . '</p>');
            echo('<div id="account-info-form" class="hidden">');
            echo('<form class="tooltip-form" action="logout.php" method="POST">');
            echo('<h2>Account Information</h2>');
            echo('<p>' . $_SESSION["firstname"] . ' ' . $_SESSION["lastname"] . ', ' . rankToString($_SESSION["rank"]) . '</p>');
            echo('<p style="text-align: right;"><input class="button" type="submit" value="logout" /></p>');
            echo('</form>');
            echo('</div>');
        }
        else
        {
            echo('<a class="menu-login">Login/Register</a>');
        }
    ?>
</div>

