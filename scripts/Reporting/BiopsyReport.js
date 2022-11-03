

$(document).ready(function() {
	console.log(totalvar);
	for (i = 0; i < totalvar; i++) { 
    	console.log(LocationName[i]);
	}
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
	        alert(diff)
        alert(date)
        
		$("#frm1").submit();
	}
    $('#collectArbalester').change(function () {
        var data = $('#frm1').serialize();
        $.ajax({
            url: application_root+"Reporting.cfc?method=getBiopsyHitdetails",
            type: "POST",
            data: data,
            success:function (data) {
                alert("agya data");
            }
        })

    })

	
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


var primary		        = '#2184DA',
    primaryTransparent  = 'rgba(33,132,218,0.15)',
    primaryLight	    = '#60A1DA',
    primaryDark	        = '#1e77c5',
    info		        = '#38AFD3',
    infoLight	        = '#6FBDD5',
    infoDark	        = '#2d8ca9',
    success		        = '#17B6A4',
    successTransparent	= 'rgba(23,182,264,0.15)',
    successLight	    = '#59C2B7',
    successDark	        = '#129283',
    warning		        = '#fcaf41',
    warningLight	    = '#EEBD77',
    warningDark	        = '#ca8c34',
    inverse		        = '#3C454D',
    inverseTransparent	= 'rgba(60,69,77,0.15)',
    grey		        = '#aab3ba',
    purple		        = '#9b59b6',
    purpleTransparent	= 'rgba(155,89,182,0.15)',
    purpleLight	        = '#BE93D0',
    purpleDark	        = '#7c4792',
    danger              = '#F04B46',
    white               = '#fff';


Chart.defaults.global = {
    animation: true,
    animationSteps: 60,
    animationEasing: 'easeOutQuart',
    showScale: true,
    scaleOverride: false,
    scaleSteps: null,
    scaleStepWidth: null,
    scaleStartValue: null,
    scaleLineColor: '#ddd',
    scaleLineWidth: 1,
    scaleShowLabels: true,
    scaleLabel: '<%=value%>',
    scaleIntegersOnly: true,
    scaleBeginAtZero: false,
    scaleFontFamily: '""Nunito", sans-serif',
    scaleFontSize: 12,
    scaleFontStyle: '300',
    scaleFontColor: '#30373e',
    responsive: true,
    maintainAspectRatio: true,
    showTooltips: true,
    customTooltips: false,
    tooltipEvents: ['mousemove', 'touchstart', 'touchmove'],
    tooltipFillColor: 'rgba(0,0,0,0.8)',
    tooltipFontFamily: '"Nunito", sans-serif',
    tooltipFontSize: 11,
    tooltipFontStyle: '300',
    tooltipFontColor: '#fff',
    tooltipTitleFontFamily: '"Nunito", sans-serif',
    tooltipTitleFontSize: 11,
    tooltipTitleFontStyle: '300',
    tooltipTitleFontColor: '#fff',
    tooltipYPadding: 10,
    tooltipXPadding: 10,
    tooltipCaretSize: 8,
    tooltipCornerRadius: 3,
    tooltipXOffset: 10,
    tooltipTemplate: '<%if (label){%><%=label%>: <%}%><%= value %> %',
    multiTooltipTemplate: '<%= value %>',
    onAnimationProgress: function(){},
    onAnimationComplete: function(){}
}
var randomScalingFactor = function() {
    return Math.round(Math.random()*100)
};

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

   var legend = myPie.generateLegend();
   $("#legend").html(legend);


   /*=== get percentage Hit Descriptor=======*/

   Chart.defaults.global = {
    animation: true,
    animationSteps: 60,
    animationEasing: 'easeOutQuart',
    showScale: true,
    scaleOverride: false,
    scaleSteps: null,
    scaleStepWidth: null,
    scaleStartValue: null,
    scaleLineColor: '#ddd',
    scaleLineWidth: 1,
    scaleShowLabels: true,
    scaleLabel: '<%=value%>',
    scaleIntegersOnly: true,
    scaleBeginAtZero: false,
    scaleFontFamily: '""Nunito", sans-serif',
    scaleFontSize: 12,
    scaleFontStyle: '300',
    scaleFontColor: '#30373e',
    responsive: true,
    maintainAspectRatio: true,
    showTooltips: true,
    customTooltips: false,
    tooltipEvents: ['mousemove', 'touchstart', 'touchmove'],
    tooltipFillColor: 'rgba(0,0,0,0.8)',
    tooltipFontFamily: '"Nunito", sans-serif',
    tooltipFontSize: 11,
    tooltipFontStyle: '300',
    tooltipFontColor: '#fff',
    tooltipTitleFontFamily: '"Nunito", sans-serif',
    tooltipTitleFontSize: 11,
    tooltipTitleFontStyle: '300',
    tooltipTitleFontColor: '#fff',
    tooltipYPadding: 10,
    tooltipXPadding: 10,
    tooltipCaretSize: 8,
    tooltipCornerRadius: 3,
    tooltipXOffset: 10,
    tooltipTemplate: '<%if (label){%><%=label%>: <%}%><%= value %> %',
    multiTooltipTemplate: '<%= value %>',
    onAnimationProgress: function(){},
    onAnimationComplete: function(){}
}

var pieData = [
{
    value:  Math.round(GoodPercentage),
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Good'
}, {
    value:  Math.round(Hit_waterPercentage),
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Hit Water'
},{
    value:  Math.round(AngledPercentage),
    color: "#4286f4",
    highlight: "#42eef4",
    label: 'Angled'
},{
    value:  Math.round(DriverJukePercentage),
    color: "#f442ce",
    highlight: "#f4427a",
    label: 'DriverJuke'
}];

var ctx5 = document.getElementById('pie-chart-des').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
   });

   var legend = myPie.generateLegend();
   $("#legend-des").html(legend);
   
   
   
   
   
   
   /*=== get percentage Miss Descriptor=======*/

   Chart.defaults.global = {
    animation: true,
    animationSteps: 60,
    animationEasing: 'easeOutQuart',
    showScale: true,
    scaleOverride: false,
    scaleSteps: null,
    scaleStepWidth: null,
    scaleStartValue: null,
    scaleLineColor: '#ddd',
    scaleLineWidth: 1,
    scaleShowLabels: true,
    scaleLabel: '<%=value%>',
    scaleIntegersOnly: true,
    scaleBeginAtZero: false,
    scaleFontFamily: '""Nunito", sans-serif',
    scaleFontSize: 12,
    scaleFontStyle: '300',
    scaleFontColor: '#30373e',
    responsive: true,
    maintainAspectRatio: true,
    showTooltips: true,
    customTooltips: false,
    tooltipEvents: ['mousemove', 'touchstart', 'touchmove'],
    tooltipFillColor: 'rgba(0,0,0,0.8)',
    tooltipFontFamily: '"Nunito", sans-serif',
    tooltipFontSize: 11,
    tooltipFontStyle: '300',
    tooltipFontColor: '#fff',
    tooltipTitleFontFamily: '"Nunito", sans-serif',
    tooltipTitleFontSize: 11,
    tooltipTitleFontStyle: '300',
    tooltipTitleFontColor: '#fff',
    tooltipYPadding: 10,
    tooltipXPadding: 10,
    tooltipCaretSize: 8,
    tooltipCornerRadius: 3,
    tooltipXOffset: 10,
    tooltipTemplate: '<%if (label){%><%=label%>: <%}%><%= value %> %',
    multiTooltipTemplate: '<%= value %>',
    onAnimationProgress: function(){},
    onAnimationComplete: function(){}
}

var pieData = [
{
    value:  Math.round(GoodHeightPercentage),
    color: "#8c7e82",
    highlight: "#e585a3",
    label: 'Good Height'
}, {
    value:  Math.round(lowPercentage),
    color: "#85e5e5",
    highlight: "#1da551",
    label: 'Low'
},{
    value:  Math.round(HighPercentage),
    color: "#93a51d",
    highlight: "#a57a1d",
    label: 'High'
},{
    value:  Math.round(wind_effectedPercentage),
    color: "#a51d1d",
    highlight: "#a52d1d",
    label: 'Wind Effected'
}];

var ctx5 = document.getElementById('pie-chart-missdes').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
   });

   var legend = myPie.generateLegend();
   $("#legend-missdesc").html(legend);
   
 
   /*=== get percentage Hit Descriptor=======*/

   Chart.defaults.global = {
    animation: true,
    animationSteps: 60,
    animationEasing: 'easeOutQuart',
    showScale: true,
    scaleOverride: false,
    scaleSteps: null,
    scaleStepWidth: null,
    scaleStartValue: null,
    scaleLineColor: '#ddd',
    scaleLineWidth: 1,
    scaleShowLabels: true,
    scaleLabel: '<%=value%>',
    scaleIntegersOnly: true,
    scaleBeginAtZero: false,
    scaleFontFamily: '""Nunito", sans-serif',
    scaleFontSize: 12,
    scaleFontStyle: '300',
    scaleFontColor: '#30373e',
    responsive: true,
    maintainAspectRatio: true,
    showTooltips: true,
    customTooltips: false,
    tooltipEvents: ['mousemove', 'touchstart', 'touchmove'],
    tooltipFillColor: 'rgba(0,0,0,0.8)',
    tooltipFontFamily: '"Nunito", sans-serif',
    tooltipFontSize: 11,
    tooltipFontStyle: '300',
    tooltipFontColor: '#fff',
    tooltipTitleFontFamily: '"Nunito", sans-serif',
    tooltipTitleFontSize: 11,
    tooltipTitleFontStyle: '300',
    tooltipTitleFontColor: '#fff',
    tooltipYPadding: 10,
    tooltipXPadding: 10,
    tooltipCaretSize: 8,
    tooltipCornerRadius: 3,
    tooltipXOffset: 10,
	tooltipTemplate: '<%if (label){%><%=label%>: <%}%><%= value %> %',
    multiTooltipTemplate: '<%= value %>',
    onAnimationProgress: function(){},
    onAnimationComplete: function(){}
}
	var colors1 = ['#2d335b', '#535b2d', '#494949', '#d7d7d7', '#46BF4D','#7af442'
	,'#6ef442','#f4ce42','#f44274','#42d4f4','#d0ecf2','#16292d','#14849e','#d12f23','#d1ae23',
	'#ede5c7','#daedc7','#c7eddc','#c9c7ed','#edc7e8','#f20487'];
	var colors2 = ['#f20487', '#c7eddc', '#42d4f4', '#d0ecf2', '#46BF4D','#d12f23'
	,'#daedc7','#ede5c7','##b204f2','#7ff204','#10f204','#9bd0ef','#14849e','#46a9e2','#d1ae23',
	'#ede5c7','#daedc7','#c7eddc','#4be246','#46d0e2','#46a9e2'];
	var pieData = [];
	for (i = 0; i < totalvar; i++) { 
		pieData.push({
			value: Math.round(locationHit[i]),
			label:LocationName[i],
			color: colors1[i],
    		highlight: colors2[i],
		});
	}
	for (i = 0; i < totalvar; i++) { 
    	console.log(LocationName[i]);
		
	}
/*var pieData = [

{
    value:  Math.round(HeadLocations),
    color: "#46BF4D",
    highlight: "#7af442",
    label: 'Head Location'
}, {
    value:  Math.round(OtherLocations),
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Other Location'
	
}];*/

var ctx5 = document.getElementById('pie-chart-loc').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
   });

   var legend = myPie.generateLegend();
   $("#legend-loc").html(legend);




var handleGenerateGraph = function(animationOption) {
	var animationOption = (animationOption) ? animationOption : false;



	 $("#bar-chart").click(
		function(evt){
			var activeBars = barChart.getBarsAtEvent(evt);
			if (typeof activeBars[0] != 'undefined') {
				startYear = $("#fromYear").val();
				endYear = $("#toYear").val();
			$.ajax({
				url:application_root+"Reporting.cfc?method=getRollCallGrapghMonth",
				type : "get",
				data : {monthName : activeBars[0].label,fromYear:startYear,toYear:endYear},
				success:function(data) {
				console.log(data);
				res = JSON.parse(data);
				console.log(res);
				count = Object.keys(res.DATA).length;
				console.log(count);
				var j ;
				$('#tbl_row').html('');
				for (i=0; i < count; i++) {
					j= i + 1;
					console.log(i);
					if(res.DATA[i][8] === null) { sex = 'N/A';} else {sex = res.DATA[i][8];}
					$('#tbl_row').append('<tr><td width="80">'+j+'</td><td width="100">'+res.DATA[i][7]+'</td><td width="120"><form action="/?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank"><input type="hidden" name="project_id" value="'+res.DATA[i][1]+'"><input type="hidden" name="sight_id" value="'+res.DATA[i][0]+'"><span class="sighting-detail">'+res.DATA[i][0]+'</span></form></td><td width="250">'+res.DATA[i][6]+'</td><td width="50">'+sex+'</td></tr>');
					}
					$('#month_title').html('List of Dolphins for ' + activeBars[0].label);
					$('#summary1').modal('show');


				}
			});
		}
		}
	);



}

handleGenerateGraph();

$('.dataToggle').click(function() {

     $('.dataToggle').not(this).each(function(){
		 id  = $(this).attr("id");
		$("#collapse"+id).removeClass('in');
     });

	});

 $(document).on("click",".sighting-detail",function(){
     var form = $(this).closest("form");
     form.submit();
   });




});
function SubmitForm(id)
{
	document.getElementById(id).submit();
}