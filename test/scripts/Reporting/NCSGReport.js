

$(document).ready(function() {
	//console.log(totalvar);
	/*for (i = 0; i < totalvar; i++) { 
    	console.log(LocationName[i]);
	}*/
	current_month = moment(new Date()).format("M");
	current_date = moment(new Date()).format("MMMM D, YYYY");
	
	d = new Date(new Date().getFullYear(), 0, 1);
	
	start_date = moment(d).format("YYYY-MM-DD");
	var monthNames = [ "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December" ];				
	    function diff(from, to) {
        var arr = [];
        var datFrom = new Date('1 ' + from);
        var datTo = new Date('1 ' + to);
        var fromYear =  datFrom.getFullYear();
        var toYear =  datTo.getFullYear();
        var diffYear = (12 * (toYear - fromYear)) + datTo.getMonth();
    
        for (var i = datFrom.getMonth(); i <= diffYear; i++) {
            arr.push(monthNames[i%12]);
        }        
        
        return arr;
    }	
	
	function get_BiopsyReportData(diff,date) {
		$("#frm1").submit();
	}
	
	//get_BiopsyReportData(current_month,start_date);
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
		get_BiopsyReportData(month_diff,e.format("YYYY-MM-DD"));
		labels = diff(e.format("MMMM  YYYY"), t.format("MMMM YYYY"));
	});

});

