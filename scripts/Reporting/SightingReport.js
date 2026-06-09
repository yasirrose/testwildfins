$(document).ready(function () {

  $('#allReport').DataTable({
		"pageLength": 100,
		"scrollX": true,
		"paging": false,
		"messageTop": null,
		"info": false,
		"responsive": true,
		"title": false,
		dom: 'Brtip',
		buttons: [
			{
				extend: 'copy',
            },
            {
                extend: 'excelHtml5',
                title: null
            },
            {
                extend: 'csv',
            }
          
        ]
	});
  // $(".buttons-html5").removeClass("dt-button");
  // $(".buttons-html5").removeClass("buttons-excel");
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

function paginate(value){
	$("#pge").val(value);
	$("#searchAllReports").submit();
}

function getcode(){
	const v = $('select[name="cetaceanSpecies"]').val();
	
	console.log(v);
	$.ajax({
		url: application_root + "StaticDataNew.cfc?method=getCetaceancode",
		type: "post",
		data: {
			codes:v
		},
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);			
			$('select[name="code"]').empty();
			$('select[name="code"]').append('<option value="">Select Code</option>');
			for (var i = 0; i < obj.DATA.length; i++) {
				$('select[name="code"]').append('<option value="'+obj.DATA[i][1]+'">'+obj.DATA[i][1]+'</option>');
			}
			
		}
	});
}

function clearAll(){
  localStorage.clear();
    $("#date").val('');
    $("#IR_Type").val(' ');
    $("#IR_CountyLocation").val(' ');

    // Clear multiple selects
    $("#BodyOfWater").val([]).trigger('change');
    $("#SurveyRoute").val([]).trigger('change');
    $("#Platform").val([]).trigger('change');
    $("#SurveyType").val([]).trigger('change');
    $("#NOAAStock").val([]).trigger('change');
    $("#searchActivity").val([]).trigger('change');
    $("#searchActivityNumber").val([]).trigger('change');
    $("#BehavioralSpecifics").val([]).trigger('change');
    $("#BodyCondition").val([]).trigger('change');
    $("#LesionType").val([]).trigger('change');

    // Clear input fields
    $("#BehavioralSpecificsNumber").val('');

    // Uncheck all checkboxes
    $('input[type="checkbox"]').prop('checked', false);
}

						   
// function ApplyPagination(startmeup){
// 	document.searchform.startHereIndex.value = startmeup;
// 	document.searchform.submit();
// }

