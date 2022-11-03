function deleteRecord(id) {
    bootbox.confirm("Are you sure?", function(result) {

        if (result == true) {
            $.ajax({
                url: application_root + "StaticDataNew.cfc?method=DeleteIR_CountyLocation",
                type: "get",
                data: {
                    id: id
                },
                success: function(data) {
                    $('html, body').animate({
                        scrollTop: 0
                    }, 800);
                    $(".message").show();
                    $("#remov_" + id).remove();
                    setTimeout(function() {
                        $(".message").hide();
                    }, 3000);
                }
            });
        }
    });
}

function updateRecord(id) {
    $('#IR_CountyLocation').val($('#cam-' + id).text());
    $("#add").attr('name', 'editIR_CountyLocation');
    $("#add").text('Edit');
    $("#IR_CountyLocation_id").val(id);
    seletecActiveValue = $('#seletecActiveValue-' + id).val();
    $('#active').val(seletecActiveValue);
    $("html, body").animate({
        scrollTop: 0
    }, 600);

}

$('form').formValidation({
    framework: 'bootstrap',
    icon: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
        IR_CountyLocation: {
            validators: {
                notEmpty: {
                    message: 'Please enter IR_CountyLocation'
                }
            }
        }
    }
});

function ApplyPagination(startmeup) {
    document.paginationform.startHereIndex.value = startmeup;
    document.paginationform.submit();
}