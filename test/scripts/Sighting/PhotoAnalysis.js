$(document).ready(function () {
	$('#example').DataTable();

	$(document).on('click', '.btnShowSurvey', function (e) {
		var IDs = $(this).data("id").split(",");
		$('input[name=Project_ID]').val(IDs[0]);
		$('input[name=Sight_ID]').val(IDs[1]);
		$('#showSurvey').submit();
	});
	$("input[name='date']").daterangepicker({
		opens: "right",
		format: "YYYY-MM-DD",
		separator: " - ",
		startDate: "01/01/" + moment().format('YYYY'),
		endDate: moment(),
		minDate: "01/01/1990",
		maxDate: "12/31/2021"
	});
});
function showdate(){
$('#date').trigger('click');
}
function ApplyPagination(startmeup) {
	document.paginationform.startHereIndex.value = startmeup;
	document.paginationform.submit();
}