function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticDataNew.cfc?method=DeleteGHeading",
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
	$('#GHeading').val($('#cam-'+id).text());
	$("#add").attr('name', 'editGHeading');
	$("#add").text('Edit');
	$("#GHeading_id").val(id);
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
			DESCS  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter DESCS'
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