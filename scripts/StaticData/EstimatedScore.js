function deleteRecord(id) {

	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticData.cfc?method=DeleteEstimatedScore",
		type : "get",
		async:true,
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
	$('#EstimatedScoreName').val($('#es-'+id).text());
	$("#add").attr('name', 'editEstimatedScore');
	$("#add").text('Edit');
	$("#es_id").val(id);
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			EmaciatedScore  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Estimated Score'
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