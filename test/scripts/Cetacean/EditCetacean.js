$(document).ready(function() {
    handleDateTimePicker = function() {
        "use strict";
        $(".datetimepicker").datetimepicker({
            format: 'YYYY-MM-DD'
        })
    }
    handleDateTimePicker();
}); //ready
$('#update_cetacean').on('submit', function(e) {
    // Prevent form submission
    e.preventDefault();
    var fd = new FormData(document.getElementById("update_cetacean"));
    $.ajax({
        url: application_root + "Cetaceans.cfc?method=update_new_cetacean",
        type: "POST",
        data: fd,
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        success: function(res) {
            $(".message").show();
			$(".message").html(res);
			setTimeout(function(){$(".message").hide();},4000);
        }
    });
});

function deleteBestImage(imgId,ID,isPrimaryImage,bestImageName){
    bootbox.confirm("Are you sure?", function(result) {
    if (result == true) {
        $.ajax({
            url: application_root + "Cetaceans.cfc?method=delete_cetacean_image",
            type: "POST",
            data: {ID: ID,isPrimaryImage: isPrimaryImage,bestImageName: bestImageName},
            success: function(res) {
                $('#delete_image_'+imgId).remove();
                if(imgId == 1) {
                    $("#oldImage").val("");
                }else{
                    $("#SecOldImage").val("");
                }
                $(".message").show();
                $(".message").html(res);
            }, error:function(err) {
            console.log("err:",err);
            }
        });
     }
    });
}