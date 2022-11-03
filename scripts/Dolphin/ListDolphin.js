function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"Dolphin.cfc?method=DeleteDolphin",
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

function ApplyPagination(startmeup)
{
	document.searchfrom.startHereIndex.value = startmeup;
	document.searchfrom.submit();
}
