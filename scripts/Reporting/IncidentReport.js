$(document).ready(function () {
  $('#data-table').DataTable( {
    dom: 'Bfritp',
    buttons: [
      {
          extend: 'excelHtml5',
          title: 'Incident Report',
          autoFilter: true,
          text:"Export Excel",
          className: 'btn btn-success'
      },
    ]
  });
  $(".buttons-html5").removeClass("dt-button");
  $(".buttons-html5").removeClass("buttons-excel");
	$('input[name="date"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
        startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
    });
});
function showdate(){
	$('#date').trigger('click');
}
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
function clearAll(){
  localStorage.clear();
$("#date").val('');
$("#IR_Type").val(' ');
$("#IR_CountyLocation").val(' ');
}

						   
// function ApplyPagination(startmeup){
// 	document.searchform.startHereIndex.value = startmeup;
// 	document.searchform.submit();
// }

