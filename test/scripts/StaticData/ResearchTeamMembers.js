function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {

	if (result == true) {
	$.ajax({
		url:application_root+"StaticData.cfc?method=DeleteResearchTeamMembers",
		type : "get",
		async : true,
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
	$('#RT_MemberName').val($('#RT-'+id).text());

	$("#add").attr('name', 'editResearchTeamMembers');

	seletecActiveValue = $('#seletecActiveValue-'+id).val();
	$('#active').val(seletecActiveValue);


	$("#add").text('Edit');
	$("#RT_ID").val(id);
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			RT_MemberName  : {
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