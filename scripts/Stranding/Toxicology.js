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
        $('#datetimepicker_Date').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
        $('#collection_date_picker').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#collection_date").formValidation('revalidateField', name);
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
var count=0;
function newToxi(){
    count = ++count;

    $( "#Toxi" ).append('<div class="row toxi-rw"><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><input type="text" placeholder="Toxin" value="" name="toxi_label" id="toxi_label" required><input type="text" maxlength="8" value="" name="toxi_type" id="toxi_type" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><label >Reference Range</label><input type="text" maxlength="8" value="" name="toxi_range"  id="toxi_range" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><label class="t-cust-l">Sample Result</label><select name="toxi_report" id="toxi_report" ><option value="High">High</option><option value="Low">Low</option><option value="Critical Result">Critical Result</option><option value="Corrected">Corrected</option><option value="None">None</option></select></div></div>');
    $("#dynamic_Toxi").val(count);

    $("#toxi_label").val();
}


$( "#deleteToxicologyAllRecord" ).click(function() {
    $('#date').val('mm/dd/yyyy');
    $('#Fnumber').val(' ');
  });