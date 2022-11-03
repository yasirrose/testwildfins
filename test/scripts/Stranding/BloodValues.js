$(document).ready(function() {
    handleDateTimePicker = function () {
        "use strict";
        $('#datetimepicker_StartTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#StartTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_EndTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#EndTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Time').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#Time").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Chem_dateTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#Chem_dateTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
        $('#collection_date_picker').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#collection_date").formValidation('revalidateField', name);
        });
        $('#ISTAT_CG4_date_picker').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#ISTAT_CG4_date").formValidation('revalidateField', name);
        });
        $('#Chem_date_picker').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#Chem_date").formValidation('revalidateField', name);
        });
    
    }  
    handleDateTimePicker();
    handleJqueryTagIt(); 
})
function chkreq(e){
    if($("#Fnumber").val().trim() == ""){
        $("#Fnumber").val('');
    }
    if($("#Date").val().trim() == ""){
        $("#Date").val('');
    }
}

$( "#deleteBloodValuesRecord" ).click(function() {
    // alert( "Handler for .click() called." );
    $('#date').val('YYYY-MM-DD');
    $('#Fnumber').val(' ');
  });