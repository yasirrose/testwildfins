$(document).ready(function(e) {
   
   $('.COA_avg').html(COA_Avg)
   var handleBootstrapCombobox = function() {
        "use strict";
        $('.combobox').combobox();
   };
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

var ChartData = {
    labels : Mom_Calf,
    datasets : [
        {
            data :Mom_Calf_COA
        }
    ]
};
/*var UnknownHomeRangeChart = {
    labels : Unknown_Home_Range,
    datasets : [
        {
            data :UnknownHomeRangeCount
        }
    ]
};*/

if(Mom_Calf.length){
	var handleGenerateGraph = function(animationOption) {
		var animationOption = (animationOption) ? animationOption : false;
		var ctx2 = document.getElementById('barChart').getContext('2d');
		
		ctx2.canvas.height = 193;
		
		 window.barChart = new Chart(ctx2).Bar(ChartData, {
			animation: animationOption,
			responsive : true
		});
		barChart.datasets[0].bars[0].fillColor = "orange";
		barChart.update();
	}
	handleGenerateGraph();
}
$(document).on("click",".sighting-detail",function(){
 	var form = $(this).closest("form");
 	form.submit();
});

/*if(Unknown_Home_Range.length){
	var handleUnkownHomeRangeGraph = function(animationOption) {
		var animationOption = (animationOption) ? animationOption : false;
		var ctx2 = document.getElementById('UnknownHomeRange_Chart').getContext('2d');
		
		ctx2.canvas.height = 193;
		
		 window.UnknownbarChart = new Chart(ctx2).Bar(UnknownHomeRangeChart, {
			animation: animationOption,
			responsive : true
		});
		UnknownbarChart.datasets[0].bars[0].fillColor = "red";
		UnknownbarChart.update();
	}
	handleUnkownHomeRangeGraph();}*/
handleBootstrapCombobox();

});

/*$("#UnknownHomeRange_Chart").click(
	function(evt){
		var activePoints = UnknownbarChart.getBarsAtEvent(evt);
		var fromYear = $("#StartYear").val();
		if(activePoints[0] !== undefined){
			console.log(UnknownHomeRangeDolphins);
			$.ajax({
					url : "http://test.wildfins.org/Modules/Reporting/getGraphDetails.cfm",
					method : "POST",
					data : {label : activePoints[0].label, fromYear : fromYear, Dolphins : UnknownHomeRangeDolphins},
					success : function(responce){
								$('#unknownHomeRange-modal-title').text('Dolphins in Segment '+activePoints[0].label);
								$('#unknownHomeRange-modal-body').html(responce);
								$('#unknownHomeRange-model').modal('show');
							}
				});
		}
	});*/
