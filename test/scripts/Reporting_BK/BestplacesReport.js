$(document).ready(function() {



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
    tooltipTemplate: '<%if (label){%><%=label%>: <%}%><%= value %>',
    multiTooltipTemplate: '<%= value %>',
    onAnimationProgress: function(){},
    onAnimationComplete: function(){}
}


   
var pieData = [ {
    value: summary2[0],
   color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Fetals'
}, {
    value: summary2[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'BC'
}, {
    value: summary2[2],
     color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Xeno'
},
{
    value: summary2[3],
     color: "#A7DBDB",
    highlight: "#28ABE3",
    label: 'RDS'
},{
    value: summary2[4],
     color: "orange",
    highlight: "orange",
    label: 'REM'
},{
    value: summary2[5],
     color: "#75EB00",
    highlight: "#9B539C",
    label: 'Fresh wound'
}];

  

var handleGenerateGraph = function(animationOption) {
	
	var animationOption = (animationOption) ? animationOption : false;
	
	/*var ctx2 = document.getElementById('bar-chart').getContext('2d');

    ctx2.canvas.height = 193;
    var barChart = new Chart(ctx2).Bar(barChartData, {
        animation: animationOption,
		responsive : true
    });
	
	
	barChart.datasets[0].bars[0].fillColor = "green"; 
    barChart.datasets[0].bars[1].fillColor = "orange"; 
    barChart.datasets[0].bars[2].fillColor = "red"; 
	 barChart.datasets[0].bars[3].fillColor = "yellow"; 
	 barChart.datasets[0].bars[4].fillColor = "#69D2E7"; 
	 barChart.datasets[0].bars[5].fillColor = "#A7DBDB"; 
	 barChart.datasets[0].bars[6].fillColor = " #28ABE3"; 
	 barChart.datasets[0].bars[7].fillColor = "#1FDA9A"; 
	 barChart.datasets[0].bars[8].fillColor = "#FF4C65"; 
	 barChart.datasets[0].bars[9].fillColor = "#6E9ECF"; 
	 barChart.datasets[0].bars[10].fillColor = "#75EB00"; 
	 barChart.datasets[0].bars[11].fillColor = "#9B539C"; 
    barChart.update();*/
	
	
	best_place = JSON.parse(total_best_place);
	total_best_place=[];
	for (i = 0; i < best_place.length; i++) {
		total_best_place.push(best_place[i]); 
	}
	
	
	var barChartData = {
    labels : ['1','1A','2','2A','3','3A','4','4A'],
    datasets : [
        {
            data : total_best_place
        }
    ]
};


var ctx2 = document.getElementById('bestplace-chart').getContext('2d');
ctx2.canvas.height = 232;
 barChart = new Chart(ctx2).Bar(barChartData, {
	animation: true
});
	

	barChart.datasets[0].bars[0].fillColor = "green"; 
    barChart.datasets[0].bars[1].fillColor = "orange"; 
    barChart.datasets[0].bars[2].fillColor = "red"; 
	 barChart.datasets[0].bars[3].fillColor = "yellow"; 
	 barChart.datasets[0].bars[4].fillColor = "#69D2E7"; 
	 barChart.datasets[0].bars[5].fillColor = "#A7DBDB"; 
	 barChart.datasets[0].bars[6].fillColor = " #28ABE3"; 
	 barChart.datasets[0].bars[7].fillColor = "#1FDA9A"; 
    barChart.update();
	
	
	
 var ctx5 = document.getElementById('pie-chart').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });
	
	
	 $("#pie-chart").click( 
                        function(evt){
                            var activePoints = myPie.getSegmentsAtEvent(evt);
							if (typeof activePoints[0] != 'undefined') {
								console.log()
								if (activePoints[0].label == 'Fetals') {
									$('#fetal').modal('show');
								} else if (activePoints[0].label == 'BC') {
									$('#bc').modal('show');
								} else if (activePoints[0].label == 'Xeno') {
									$('#xeno').modal('show');
								} else if (activePoints[0].label == 'RDS') {
									$('#rds').modal('show');
								} else if (activePoints[0].label == 'REM') {
									$('#rem').modal('show');
								} else if (activePoints[0].label == 'Fresh wound') {
									$('#freshwound').modal('show');
								}
								
							}
                            //alert(activePoints[0].label);
                        }
                    );                  
	
	
	var legend = myPie.generateLegend();
$("#legend").html(legend);
	

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