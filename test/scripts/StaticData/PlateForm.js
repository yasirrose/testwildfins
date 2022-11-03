function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticData.cfc?method=DeletePlateForm",
		type : "get",
		data : {id : id},
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

function updateRecord(id) {
	$("html, body").animate({ scrollTop: 0 }, 600);
	$('#Name').val($('#plateform-'+id).text());
	$("#add").attr('name', 'editPlateForm');
	$("#add").text('Edit');
	$("#plateform_id").val(id);
	seletecActiveValue = $('#seletecActiveValue-'+id).val();
	$('#active').val(seletecActiveValue);
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			Name  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Name'
                    }
                }
            }
        }
    });
function ApplyPagination(startmeup)
{
	document.paginationform.startHereIndex.value = startmeup;
	document.paginationform.submit();
}