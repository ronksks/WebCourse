$(document).ready(function () {
    $(".btn").on("click", function () {
        var t = $(this).text();
        var o = $("#screen").text();
        if (t == "=") {
            var str = eval(o);
            var res = o + "=" + str;
            $("#screen").text(res);
        } else if (t == "מחק") {
            var s = o.substr(0, o.length - 1);
            $("#screen").text(s);
        } else if (t == "מחק הכל") {
            $("#screen").text("");
        } else {
            var s = $("#screen").text();
            s += t;
            $("#screen").text(s);
        }
    })
})