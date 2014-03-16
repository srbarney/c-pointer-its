function countChar(val, max, outName) {
    var len = val.value.length;
    if (len >= max)
    {
        val.value = val.value.substring(0, max);
        $('#' + outName).html('At ' + max + ' Character Limit');
    }
    else
    {
        $('#' + outName).html('Characters Left: ' + (max - len));
    }
}

function limitNum(val, max) {
    var len = val.value.length;
    var lastChar = val.value.substr(len - 1);
    if (lastChar != '.' && isNaN(parseInt(lastChar)))
    {
        val.value = val.value.substring(0, len - 1);
    }
    if (len >= max)
    {
        val.value = val.value.substring(0, max);
    }
}