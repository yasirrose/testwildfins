$(document).ready(function(){
handleDateTimePicker = function() {
    "use strict";
    $(".datetimepicker").datetimepicker({
        format: 'MM/DD/YYYY'
    })
}
	
handleDateTimePicker();

$('#add_cetacean').on('submit', function(e) {
    e.preventDefault();
    var fd= new FormData(document.getElementById("add_cetacean"));
    $.ajax({
        url:application_root+"Cetaceans.cfc?method=add_cetaceans",
        type: "POST",
        data: fd,
        enctype: 'multipart/form-data',
        processData: false,  // tell jQuery not to process the data
        contentType: false,   // tell jQuery not to set contentType
        success:function(res){
            $(".reset").trigger("click");
            $(".fileinput-remove").trigger( "click" );
            $(".message").show();
            $(".message").html(res);
            setTimeout(function(){$(".message").hide();},4000);
        }
    });
});

});