$(document).ready(function () {
	$('#allReport').DataTable({
		"pageLength": 100,
		"scrollX": true,
		"paging": false,
		"info":    false,
		responsive: true,
		dom: 'rtip',
	});

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
function clearAll(){
	$('#date').val('');
	$('select[name="cetaceanSpecies"]').val('');
	$('select[name="surveyRoute"]').val('');
	$('select[name="code"]').val('');
	$('select[name="Region"]').val('');
	$('select[name="bodycondition"]').val('');
	$('select[name="Head_NuchalCrest"]').val('');
	$('select[name="Head_LateralCervicalReg"]').val('');
	$('select[name="Head_FacialBones"]').val('');
	$('select[name="Head_EarOS"]').val('');
	$('select[name="Head_ChinSkinFolds"]').val('');
	$('select[name="Body_EpaxialMuscle"]').val('');
	$('select[name="Body_DorsalRidgeScapula"]').val('');
	$('select[name="Body_Ribs"]').val('');
	$('select[name="Tail_TransversePro"]').val('');
	$('#LesionType').val(null).trigger('change');
}
function excel(){
	form=document.getElementById('searchAllReports');
	form.action='http://test.wildfins.org/index.cfm?Module=Reporting&Page=ExportLesion';
	form.submit();
	form.action='';
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

