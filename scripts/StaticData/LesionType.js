function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
		const recordType = $(`#selectedLesionScar-${id}`).val();
	if (result == true) {
	$.ajax({
		url:application_root+"StaticDataNew.cfc?method=DeleteLesionType",
		type : "get",
		data : {id : id, type: recordType},
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
	$('#LesionTypeName').val($('#cam-'+id).text());
	
	$('#LesionScar').val($('#cam-'+id).val());
	// let lesionScarValue = $('#selectedLesionScar-' + id).val();
    // $('#LesionScar').val(lesionScarValue);

	// $('#LesionScar').prop('disabled', true);

	let lesionScarValue = $('#selectedLesionScar-' + id).val();
    $('#LesionScar').val(lesionScarValue);
    $('#LesionScarHidden').val(lesionScarValue); 
    $('#LesionScar').prop('disabled', true); 
	
	$("#add").attr('name', 'editLesionType');
	$("#add").text('Edit');
	$("#LesionType_id").val(id);
	seletecActiveValue = $('#seletecActiveValue-'+id).val();
	$('#active').val(seletecActiveValue);
	$("html, body").animate({ scrollTop: 0 }, 600);
	
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			LesionTypeName  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter TypeName'
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