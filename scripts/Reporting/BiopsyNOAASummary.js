$(document).ready(function() {
	//var BarHitss = BarHits;
	//console.log(getHitDistance);
	//console.log(getMissDistance);
	
/*=== get percentage for hits vs misses=======*/
var pieData = [
{
    value:  Math.round(Hit),
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Hit'
}, {
    value:  Math.round(Miss),
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Miss'
}];
var ctx5 = document.getElementById('pie-chart').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
   });
 /*===== End Pie Chart =====*/

/*=========** Start Bar Chart **===========*/

var res=[{
	value:Hit
	}]

var barChartData = {
    labels : ['3 meter','4 meter','5 meter ','6+ meter '],
      
	labelDisplay:['Hit','Miss','Hit','Miss'],
    datasets : [
       {
            data :getHitDistance,
			 fillColor : '#00cc66',
			// label :'Hit'
        },{
			
			data :getMissDistance,
			fillColor : '#ff6666',
			 //label :'Hit'
			
			}
    ]
};

var handleGenerateGraph = function(animationOption) {
	var animationOption = (animationOption) ? animationOption : false;
	var ctx2 = document.getElementById('bar-chart').getContext('2d');

    ctx2.canvas.height = 158;
	//ctx2.labels =['Hit','Hit','Hit','Miss'];
	  //ctx2.color = "#46BFBD",
     window.barChart = new Chart(ctx2).Bar(barChartData, {
        animation: animationOption,
		responsive : true
    });
	
	var legend = barChart.generateLegend();
	   // barChart.datasets[0].bars[0].fillColor = "orange"; 
 var ctx5 = document.getElementById('pie-chart').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<br><br><br><ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
 });
	
}
handleGenerateGraph();

var legend = myPie.generateLegend();
   $("#legend").html(legend);

});

/*=========** End Bar Chart **===========*/

function SubmitForm(id)
{
	document.getElementById(id).submit();
}

function get_BiopsyReportData(diff,date) {
		$("#frm1").submit();
	}
	
	//get_BiopsyReportData(current_month,start_date);
	$("#Date-range").daterangepicker({
		opens: "right",
		format: "MM/DD/YYYY",
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