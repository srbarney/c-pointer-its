<div id="master-header">
    <h1 class="main-title"><span class="init-cap">T</span>HE <span class="highlight init-cap">C</span> <span class="init-cap">P</span>OINTER <span class="init-cap">T</span>UTOR</h1>
    <p class="nav-menu">
        <a class="nav-link" href="/index.html"><span class="init-cap">*H</span>OME</a>
        <a class="nav-link" href="/lessons.html"><span class="init-cap">L</span>ESSONS</a>
        <a class="nav-link" href="/about.html"><span class="init-cap">A</span>BOUT</a>
        <?php
        if (isset($_SESSION['status']) && $_SESSION['status'] == 1)
        {
            echo('<a class="nav-link accent-text menu-account-info"><span class="init-cap">W</span>ELCOME, ' . strtoupper($_SESSION["firstname"]) . '</a>');
            echo('<div id="account-info-form" class="hidden">');
            echo('<div class="tooltip-form">');
            echo('<h2 class="tooltip-header accent-text"><span class="init-cap">A</span>CCOUNT <span class="init-cap">I</span>NFORMATION</h2>');
            echo('<form action="logout.php" method="POST">');
            echo('<p class="white-text"><span class="init-cap">' . strtoupper($_SESSION["firstname"]) . ' ' . strtoupper($_SESSION["lastname"]) . '</span>, <span class="small-text">' . strtoupper(rankToString($_SESSION["rank"])) . '</span></p>');
            if(isset($_SESSION['rank']) && $_SESSION['rank'] >= 2)
            {
                echo('<p class="white-text"><a href="dashboard.html"><span class="init-cap">A</span>CCESS <span class="init-cap">D</span>ASHBOARD</a></p>');
            }
            if(isset($_SESSION['rank']) && $_SESSION['rank'] == 3)
            {
                echo('<p class="white-text"><a href="html-tools.html"><span class="init-cap">HTML T</span>OOLS</a></p>');
            }
            echo('<p style="text-align: right;"><input class="button" type="submit" value="logout" /></p>');
            echo('</form>');
            echo('</div>');
            echo('</div>');
        }
        else
        {
            echo('<a class="nav-link accent-text menu-login"><span class="init-cap">L</span>OGIN</a>');
        }
        ?>
    </p>
</div>

