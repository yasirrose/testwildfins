function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	if (result == true) {

	$.ajax({
		url:application_root+"StaticData.cfc?method=DeleteDolphinCondition",
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
	$('#DolphinConditionName').val($('#des-'+id).text());
	$("#add").attr('name', 'editDolphinCondition');
	$("#add").text('Edit');
	$("#DolphinCondition_id").val(id);
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			ConditionDesc  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Condition'
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
