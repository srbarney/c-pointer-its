$(document).ready(function() {
    $("#master-header").sticky({ topSpacing: 0 });

    /* Initialize Login/Register ToolTip */
    var loginForm = '<div class="tooltip-form"><h2 class="tooltip-header accent-text"><span class="init-cap">U</span>SER <span class="init-cap">L</span>OGIN</h2>' +
        '<form action="login.php" method="POST"><fieldset>' +
        '<p><label class="form-label white-text" for="log_email"><span class="init-cap">E-M</span>AIL</label><input id="log_email" name="log_email" required="" type="text"></p>' +
        '<p><label class="form-label white-text" for="log_password"><span class="init-cap">P</span>ASSWORD</label><input id="log_password" name="log_password" required="" type="password"></p>' +
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
    $('.tooltip').powerTip({ mouseOnToPopup: true });
    $('.hint-tooltip').powerTip({ manual: true });

    /* Initialize backstretch for site background */
    $.backstretch("../images/background.jpg");
});