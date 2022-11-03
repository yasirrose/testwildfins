function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticData.cfc?method=DeleteSurveyArea",
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
	$('#AreaName').val($('#AreaName-'+id).text());
	$("select[name=stock]").val($('#StockID-'+id).data("id"));
	$("#add").attr('name', 'editSurveyArea');
	$("#add").text('Edit');
	$("#Area_id").val(id);
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
			AreaName  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter AreaName'
                    }
                }
            },
			stock  : {
                validators: {
                    notEmpty: {
                        message: 'Please select NOAA Stock'
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
