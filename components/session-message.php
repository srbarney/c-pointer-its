<?php
// If message is set and not empty, display it
if (isset($_SESSION['message']) && !empty($_SESSION['message']))
{
    echo('<div class="session-message-wrapper">');
    echo('<img class="session-message-close" src="icons/close.png" alt="X" onclick="$(\'.session-message-wrapper\').slideUp(200);"/>');
    echo('<p class="session-message center">' . $_SESSION['message'] . '</p>');
    echo('</div>');

    // Clear message from the session after it is displayed
    unset($_SESSION['message']);

    // Include JavaScript Timeout on session message
    echo('<script>');
    echo('window.setTimeout(function(){$(\'.session-message-wrapper\').slideUp(200)}, 10000);');
    echo('</script>');
}
?>