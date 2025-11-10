function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
		$.ajax({
			url:application_root+"Group.cfc?method=DeleteGroup",
			type : "get",
			data : {id : id},
			async:true,
			success:function(data) {
				window.location.reload();
			}
		});
	}
	}); 
}

function updateRecord(id) {
	$("html, body").animate({ scrollTop: 0 }, 600);
	$('#group-edit').show();
	$('#group_name').val($('#group_name-'+id).text());
	$('#group_status').val($('#group_status-'+id).text());
	$( "#group_status option:selected" ).text($('#group_status-'+id).text());
	$('#group_description').val($('#group_description-'+id).text());
	$("#group_id").val(id);
}



$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			group_name  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Group Name'
                    }
                }
            },
			group_description  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Group description'
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

