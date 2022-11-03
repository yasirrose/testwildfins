function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticData.cfc?method=DeleteTeamMembers",
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
	$('#RT_MemberName').val($('#RT-'+id).text());
	$("#add").attr('name', 'editTeamMembers');
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
                        message: 'Please enter RT_MemberName'
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