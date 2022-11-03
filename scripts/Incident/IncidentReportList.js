$(document).ready(function () {
	$('#data-table').DataTable();
});
function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	if (result == true) {
	$.ajax({
		url:application_root+"IncidentReport.cfc?method=DeletIncidentReport",
		type : "get",
		data : {id : id},
		success:function(data) {
         var obj = JSON.parse(data);
         if(obj.status) {
            $('.message').addClass('alert-success');
			$('.message').html(obj.message);
            $("#remov_"+id).remove();
		  } else {
            $('.message').addClass('alert-danger');
            $('.message').html(obj.message);
          }
            $('html, body').animate({scrollTop : 0},800);
            $(".message").show();
            setTimeout(function(){$(".message").hide();},3000);
         }  
	});
	}
	}); 
}

						   
// function ApplyPagination(startmeup){
// 	document.searchform.startHereIndex.value = startmeup;
// 	document.searchform.submit();
// }