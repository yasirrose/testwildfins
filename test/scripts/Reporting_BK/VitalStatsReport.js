$(document).ready(function() {
$("#Date-range").daterangepicker({
    opens: "right",
    format: "YYYY-MM-DD",
    separator: " to ",
    startDate: "01/01/"+moment().format('YYYY'),
    endDate: moment(),
    minDate: "01/01/1990",
    maxDate: "12/31/2018"}, function(e, t) {
    $("#Date-range input").val(e.format("MMMM D, YYYY") + " - " + t.format("MMMM D, YYYY"));
	 var month_diff =  Math.ceil(moment(t.format("MMMM D, YYYY")).diff(moment(e.format("MMMM D, YYYY")), 'months', true));

	});
$(".search-box").select2();
});