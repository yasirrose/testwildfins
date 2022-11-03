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

var barChartByZoneData = {
    labels : dolphinsCodeByZone,
    datasets : [
        {
            data :dolphinsSeenByZone
        }
    ]
};


var handleGenerateGraph = function(animationOption) {
	var animationOption = (animationOption) ? animationOption : false;
	var ctx4 = document.getElementById('bar-chart-by-zones').getContext('2d');

    ctx4.canvas.height = 193;
     window.barChart3 = new Chart(ctx4).Bar(barChartByZoneData, {
        animation: animationOption,
		responsive : true
    });
	
    barChart3.datasets[0].bars[0].fillColor = "red"; 
    
    barChart3.update();
 
 	$("#bar-chart-by-zones").click( 
			function(evt){
				var activeBars = barChart3.getBarsAtEvent(evt);
				var StartYear = $("#StartYear").val();
				var EndYear = $("#EndYear").val();
				if(activeBars[0] !== undefined){
					console.log(activeBars[0].label);
					$.ajax({
						url : "http://test.wildfins.org/Modules/Reporting/getBarChartSpecificDataZone.cfm",
						method : "POST",
						data : {label : activeBars[0].label,StartYear:StartYear,EndYear:EndYear,report_type:'DolphinActivity'},
						success : function(responce){
										$('#zone-modal-title').text('Dolphin Sighted in '+activeBars[0].label);
										$('#zone-modal-body').html(responce);
										$('#zone-model').modal('show');
									}	
					});
				}
			}
		);
}

handleGenerateGraph();
});