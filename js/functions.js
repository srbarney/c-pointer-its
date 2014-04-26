function checkSectionAnswer(box, sectionNum) {
    setTimeout(function() {
        answer = box.value;
        hash = $('#section-' + sectionNum + '-hash').text();
        hashAndCheck(answer, hash, sectionNum);
    },250)
}
function hashAndCheck(answer, hash, sectionNum) {
    if(answer.length > 0){
        $.ajax({
            type: "POST",
            url: "/check_answer.php",
            data: { answer: answer, hash: hash },
            cache: false,
            success: function(html){
                var success = parseInt(html);
                if (success == -1)
                    $('#section-' + sectionNum + '-feedback').removeClass().html('Enter Answer');
                else if (success == 0)
                    $('#section-' + sectionNum + '-feedback').removeClass().addClass('incorrect').html('<img src="icons/red-x-sm.png" style="margin:0;padding:0 3px 0 0;height:15px;">Incorrect');
                else if (success == 1)
                {
                    html = '<img src="icons/green-check-sm.png" style="margin:0;padding:0 3px 0 0;height:15px;">Correct&nbsp;&nbsp;&nbsp;<button class="button" onclick="showSection(this, ' + (parseInt(sectionNum) + 1) + ')">Next</button>';
                    $('#section-' + sectionNum + '-answer').attr("disabled", "disabled");
                    $('#section-' + sectionNum + '-feedback').removeClass().addClass('correct').html(html);
                }
            }
        });
    }
    else
        $('#section-' + sectionNum + '-feedback').removeClass().html('Enter Answer');
    return false;
}
function showSection(button, num)
{
    $(button).hide();
    $('.section-' + num).show();
}
