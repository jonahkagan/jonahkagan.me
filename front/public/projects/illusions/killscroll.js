document.onkeydown  = function(e) {
    var k;
    if (window.event)
        k = e.keyCode;
    else if (e.which)
        k = e.which;
    // capture up/down arrow keys and spacebar
    if (k == 38 || k == 40 || k == 32)
        return false;
}
