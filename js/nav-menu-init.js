$(document).ready(function() {
    /* Initialize JPanelMenu */
    var jPM = $.jPanelMenu({
        menu: '#nav-menu',
        trigger: '.menu-link',
        duration: 200,    /* Animation duration */
        openPosition: 200 /* Width of open menu */
    });
    jPM.on();
    $("#master-header").sticky({ topSpacing: 0 });

    /* Initialize Login/Register ToolTip */
    var loginForm = '<div class="tooltip-form"><form action="login.php" method="POST">' +
        '<h2>System Login/Register</h2><fieldset>' +
        '<p><label class="form-label" for="log_username">Username</label><input id="log_email" name="log_email" placeholder="e-mail" required="" type="text"></p>' +
        '<p><label class="form-label" for="log_password">Password</label><input id="log_password" name="log_password" placeholder="password" required="" type="password"></p>' +
        '</fieldset>' +
        '<p style="text-align: right;"><input name="login" type="submit" value="login" class="button" /></p>' +
        '</form></div>';
    var loginTip = $(loginForm);
    $('.menu-login').powerTip({ placement: 's', smartPlacement: true, mouseOnToPopup: true, manual: true })
        .data('powertipjq', loginTip)
        .on('click', function() {
            $(this).powerTip('show');
        });

    /* Initialize Account Info ToolTip */
    $('.menu-account-info').powerTip({ placement: 's', smartPlacement: true,  mouseOnToPopup: true, manual: true })
        .data('powertiptarget', 'account-info-form')
        .on('click', function() {
            $(this).powerTip('show');
        });

    /* Initialize standard tooltips */
    $('.tooltip').powerTip({ mouseOnToPopup: true })
});