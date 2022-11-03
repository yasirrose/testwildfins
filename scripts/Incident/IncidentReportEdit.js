$(document).ready(function() {
    $("#datetimepickerIR").datetimepicker({
        format: 'MM/DD/YYYY'
    });

    setTimeout(function() {
        $(".alert").hide();
    }, 5000);
});

