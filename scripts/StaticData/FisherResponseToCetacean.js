function deleteRecord(id) {
    bootbox.confirm("Are you sure?", function(result) {
        if (result == true) {
            $.ajax({
                url: application_root + "StaticDataNew.cfc?method=DeleteFisherResponseToCetacean",
                type: "get",
                data: {
                    id: id
                },
                success: function(data) {
                    var response = data;
                    if (typeof data === "string") {
                        response = JSON.parse(data);
                    }
                    if (response.success === false) {
                        bootbox.alert(response.message || "Unable to delete this record.");
                        return;
                    }

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
    $('#Desc').val($('#cam-' + id).text());
    $('#SortOrder').val($('#selectedSortOrder-' + id).val());
    $("#add").attr('name', 'editFisherResponseToCetacean');
    $("#add").text('Edit');
    $("#FisherResponseToCetacean_id").val(id);
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
        DESC: {
            validators: {
                notEmpty: {
                    message: 'Please enter DESC'
                }
            }
        },
        SortOrder: {
            validators: {
                notEmpty: {
                    message: 'Please enter sort order'
                },
                integer: {
                    message: 'Sort order must be a whole number'
                }
            }
        }
    }
});

function ApplyPagination(startmeup) {
    document.paginationform.startHereIndex.value = startmeup;
    document.paginationform.submit();
}
