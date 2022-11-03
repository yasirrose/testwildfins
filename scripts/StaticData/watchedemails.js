function updateRecord(id) {
    $('#EmailID').val($('#cam-'+id).text());
    $("#add").attr('name', 'editEmail');
    $("#add").text('Edit');
    $("#email_id").val(id);
    seletecActiveValue = $('#seletecActiveValue-'+id).val();
    $('#active').val(seletecActiveValue);
    $("html, body").animate({ scrollTop: 0 }, 600);
}

function deleteRecord(id) {
    bootbox.confirm("Are you sure?", function(result) {

        if (result == true) {
            $.ajax({
                url:application_root+"StaticData.cfc?method=deleteAdminEmail",
                type : "get",
                data : {id : id},
                async:true,
                success:function(data) {
                    $('html, body').animate({scrollTop : 0},800);
                    $(".message").show();
                    $("#remov_"+id).remove();
                    setTimeout(function(){$(".message").hide();},3000);

                }
            });
        }
    });
}