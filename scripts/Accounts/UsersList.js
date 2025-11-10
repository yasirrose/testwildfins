function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	if (result == true) {
	$.ajax({
		url:application_root+"Accounts.cfc?method=DeleteUser",
		type : "get",
		data : {id : id},
		success:function(data) {
			window.location.reload();
		}
	});
	}
	}); 
}

						   
function ApplyPagination(startmeup)
{
	document.searchform.startHereIndex.value = startmeup;
	document.searchform.submit();
}