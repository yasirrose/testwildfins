

$(document).ready(function() {
$('.sort-table').tablesorter(); 

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

var barChartData = {
    labels : dolphinsCode,
    datasets : [
        {
            
            data :dolphinsSeen
        }
    ]
};

var barChartBySegmentData = {
    labels : dolphinsCodeBySegment,
    datasets : [
        {
            
            data :dolphinsSeenBySegment
        }
    ]
};


var barChartByZoneData = {
    labels : dolphinsCodeByZone,
    datasets : [
        {
            
            data :dolphinsSeenByZone
        }
    ]
};

var all_sex_pieData = [ {
    value: all_sex_categories[0],
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Male'
}, {
    value: all_sex_categories[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Female'
}, {
    value: all_sex_categories[2],
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Unknown'
}];

var calves_sex_pieData = [ {
    value: calves_sex_categories[0],
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Calf Male'
}, {
    value: calves_sex_categories[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Calf Female'
}, {
    value: calves_sex_categories[2],
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Calf Unknown'
}];

var juvenile_sex_pieData = [ {
    value: juvenile_sex_categories[0],
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Juvenile Male'
}, {
    value: juvenile_sex_categories[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Juvenile Female'
}, {
    value: juvenile_sex_categories[2],
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Juvenile Unknown'
}];

var adult_sex_pieData = [ {
    value: adult_sex_categories[0],
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Adult Male'
}, {
    value: adult_sex_categories[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Adult Female'
}, {
    value: adult_sex_categories[2],
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Adult Unknown'
}];

var unknown_sex_pieData = [ {
    value: unknown_sex_categories[0],
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Unknown Age Male'
}, {
    value: unknown_sex_categories[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Unknown Age Female'
}, {
    value: unknown_sex_categories[2],
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Unknown Age Unknown'
}];

var pieData = [ {
    value: categories[0],
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Calf'
}, {
    value: categories[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Juvenile Male'
}, {
    value: categories[2],
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Juvenile Female'
}, {
    value: categories[3],
    color: "#9b59b6",
    highlight: "#ab71c3",
    label: 'Adult Male'
}, {
    value: categories[4],
    color: "#3C454D",
    highlight: "#808890",
    label: 'Adult Female'
}, {
    value: categories[5],
    color: "#aab3ba",
    highlight: "#c5c9cc",
    label: 'Unknown Sex'
}];

  

var handleGenerateGraph = function(animationOption) {
	var animationOption = (animationOption) ? animationOption : false;
	var ctx2 = document.getElementById('bar-chart').getContext('2d');

    ctx2.canvas.height = 193;
     window.barChart1 = new Chart(ctx2).Bar(barChartData, {
        animation: animationOption,
		responsive : true
    });
	
	barChart1.datasets[0].bars[0].fillColor = "red";
	barChart1.update();
	
	$("#bar-chart").click( 
			function(evt){
				var activeBars = barChart1.getBarsAtEvent(evt);
				var fromYear = $("#fromYear").val();
				if(activeBars[0] !== undefined){
					console.log(activeBars[0].label);
					$.ajax({
						url : "http://test.wildfins.org/Modules/Reporting/getBarChartSpecificDataBodyOfWater.cfm",
						method : "POST",
						data : {label : activeBars[0].label,fromYear:fromYear},
						success : function(responce){
										$('#bodyofwater-modal-title').text('Dolphin Sighted in '+activeBars[0].label);
										$('#bodyofwater-modal-body').html(responce);
										$('#bodyofwater-model').modal('show');
									}	
					});
				}
			}
		);
	
	 
	var ctx3 = document.getElementById('bar-chart-by-segments').getContext('2d');

    ctx3.canvas.height = 193;
     window.barChart2 = new Chart(ctx3).Bar(barChartBySegmentData, {
        animation: animationOption,
		responsive : true
    });
	barChart2.datasets[0].bars[0].fillColor = "seagreen";
	barChart2.update();
	
	$("#bar-chart-by-segments").click( 
			function(evt){
				var activeBars = barChart2.getBarsAtEvent(evt);
				var fromYear = $("#fromYear").val();
				if(activeBars[0] !== undefined){
					console.log(activeBars[0].label);
					$.ajax({
						url : "http://test.wildfins.org/Modules/Reporting/getBarChartSpecificDataSegments.cfm",
						method : "POST",
						data : {label : activeBars[0].label,fromYear:fromYear},
						success : function(responce){
										$('#segments-modal-title').text('Dolphin Sighted in '+activeBars[0].label);
										$('#segments-modal-body').html(responce);
										$('#segments-model').modal('show');
									}	
					});
				}
			}
		);
	
	
	var ctx4 = document.getElementById('bar-chart-by-zones').getContext('2d');

    ctx4.canvas.height = 193;
     window.barChart3 = new Chart(ctx4).Bar(barChartByZoneData, {
        animation: animationOption,
		responsive : true
    });
	
	 /*$("#bar-chart").click( 
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
	);*/    
	
	/*barChart.datasets[0].bars[0].fillColor = "green"; */
    barChart3.datasets[0].bars[0].fillColor = "orange"; 
    /*barChart.datasets[0].bars[2].fillColor = "red"; 
	 barChart.datasets[0].bars[3].fillColor = "yellow"; 
	 barChart.datasets[0].bars[4].fillColor = "#69D2E7"; 
	 barChart.datasets[0].bars[5].fillColor = "#A7DBDB"; 
	 barChart.datasets[0].bars[6].fillColor = " #28ABE3"; 
	 barChart.datasets[0].bars[7].fillColor = "#1FDA9A"; 
	 barChart.datasets[0].bars[8].fillColor = "#FF4C65"; 
	 barChart.datasets[0].bars[9].fillColor = "#6E9ECF"; 
	 barChart.datasets[0].bars[10].fillColor = "#75EB00"; 
	 barChart.datasets[0].bars[11].fillColor = "#9B539C"; */ 
    barChart3.update();
 
 	$("#bar-chart-by-zones").click( 
			function(evt){
				var activeBars = barChart3.getBarsAtEvent(evt);
				var fromYear = $("#fromYear").val();
				if(activeBars[0] !== undefined){
					console.log(activeBars[0].label);
					$.ajax({
						url : "http://test.wildfins.org/Modules/Reporting/getBarChartSpecificDataZone.cfm",
						method : "POST",
						data : {label : activeBars[0].label,fromYear:fromYear},
						success : function(responce){
										$('#zone-modal-title').text('Dolphin Sighted in '+activeBars[0].label);
										$('#zone-modal-body').html(responce);
										$('#zone-model').modal('show');
									}	
					});
				}
			}
		);
 
	

 
 	
 /*var ctx5 = document.getElementById('pie-chart').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });
	
	
	 /*$("#pie-chart").click( 
                        function(evt){
                            var activePoints = myPie.getSegmentsAtEvent(evt);
							if (typeof activePoints[0] != 'undefined') {
								if (activePoints[0].label == 'Seasonal') {
								$('#seasonal').modal('show');
								}
								else if (activePoints[0].label == 'Resident') {
								$('#resident').modal('show');
								}
								else if (activePoints[0].label == 'Transients') {
								$('#transient').modal('show');
								}
							}
                            //alert(activePoints[0].label);
                        }
                    );*/                  
	
	
/*var legend = myPie.generateLegend();
$("#legend").html(legend);*/


var ctx_all_sex = document.getElementById('all-sex-pie-chart').getContext('2d');
 	window.myPie_all_sex = new Chart(ctx_all_sex).Pie(all_sex_pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });	
var legend_all_sex = myPie_all_sex.generateLegend();
$("#all-sex-legend").html(legend_all_sex);


$("#all-sex-pie-chart").click( 
	function(evt){
		var activePoints = myPie_all_sex.getSegmentsAtEvent(evt);
		var fromYear = $("#fromYear").val();
		if(activePoints[0] !== undefined){
			console.log(activePoints[0].label);
			$.ajax({
					url : "http://test.wildfins.org/Modules/Reporting/getPieChartSpecificData.cfm",
					method : "POST",
					data : {label : activePoints[0].label,fromYear:fromYear},
					success : function(responce){
								$('#all-sex-modal-title').text('All '+activePoints[0].label+'s');
								$('#all-sex-modal-body').html(responce);
								$('#all-sex-model').modal('show');
							}
				});
		}
		/*if (typeof activePoints[0] != 'undefined') {
			if (activePoints[0].label == 'Seasonal') {
			$('#seasonal').modal('show');
			}
			else if (activePoints[0].label == 'Resident') {
			$('#resident').modal('show');
			}
			else if (activePoints[0].label == 'Transients') {
			$('#transient').modal('show');
			}
		}*/
	}
);


var ctx_calves_sex = document.getElementById('calves-sex-pie-chart').getContext('2d');
 	window.myPie_calves_sex = new Chart(ctx_calves_sex).Pie(calves_sex_pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });	
var legend_calves_sex = myPie_calves_sex.generateLegend();
$("#calves-sex-legend").html(legend_calves_sex);


$("#calves-sex-pie-chart").click( 
	function(evt){
		var activePoints = myPie_calves_sex.getSegmentsAtEvent(evt);
		var fromYear = $("#fromYear").val();
		if(activePoints[0] !== undefined){
			console.log(activePoints[0].label);
			
			$.ajax({
					url : "http://test.wildfins.org/Modules/Reporting/getPieChartSpecificData.cfm",
					method : "POST",
					data : {label : activePoints[0].label,fromYear:fromYear},
					success : function(responce){
								$('#calf-sex-modal-title').text('All '+activePoints[0].label+'s');
								$('#calf-sex-modal-body').html(responce);
								$('#calf-sex-model').modal('show');
							}
				});
		}
		/*if (typeof activePoints[0] != 'undefined') {
			if (activePoints[0].label == 'Seasonal') {
			$('#seasonal').modal('show');
			}
			else if (activePoints[0].label == 'Resident') {
			$('#resident').modal('show');
			}
			else if (activePoints[0].label == 'Transients') {
			$('#transient').modal('show');
			}
		}*/
	}
);



var ctx_juvenile_sex = document.getElementById('juvenile-sex-pie-chart').getContext('2d');
 	window.myPie_juvenile_sex = new Chart(ctx_juvenile_sex).Pie(juvenile_sex_pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });	
var legend_juvenile_sex = myPie_juvenile_sex.generateLegend();
$("#juvenile-sex-legend").html(legend_juvenile_sex);


$("#juvenile-sex-pie-chart").click( 
	function(evt){
		var activePoints = myPie_juvenile_sex.getSegmentsAtEvent(evt);
		var fromYear = $("#fromYear").val();
		if(activePoints[0] !== undefined){
			console.log(activePoints[0].label);
			$.ajax({
					url : "http://test.wildfins.org/Modules/Reporting/getPieChartSpecificData.cfm",
					method : "POST",
					data : {label : activePoints[0].label,fromYear:fromYear},
					success : function(responce){
								$('#juvenile-sex-modal-title').text('All '+activePoints[0].label+'s');
								$('#juvenile-sex-modal-body').html(responce);
								$('#juvenile-sex-model').modal('show');
							}
				});
		}
		/*if (typeof activePoints[0] != 'undefined') {
			if (activePoints[0].label == 'Seasonal') {
			$('#seasonal').modal('show');
			}
			else if (activePoints[0].label == 'Resident') {
			$('#resident').modal('show');
			}
			else if (activePoints[0].label == 'Transients') {
			$('#transient').modal('show');
			}
		}*/
	}
);




var ctx_adult_sex = document.getElementById('adult-sex-pie-chart').getContext('2d');
 	window.myPie_adult_sex = new Chart(ctx_adult_sex).Pie(adult_sex_pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });	
var legend_adult_sex = myPie_adult_sex.generateLegend();
$("#adult-sex-legend").html(legend_adult_sex);


$("#adult-sex-pie-chart").click( 
	function(evt){
		var activePoints = myPie_adult_sex.getSegmentsAtEvent(evt);
		var fromYear = $("#fromYear").val();
		if(activePoints[0] !== undefined){
			console.log(activePoints[0].label);
			$.ajax({
					url : "http://test.wildfins.org/Modules/Reporting/getPieChartSpecificData.cfm",
					method : "POST",
					data : {label : activePoints[0].label,fromYear:fromYear},
					success : function(responce){
								$('#adult-sex-modal-title').text('All '+activePoints[0].label+'s');
								$('#adult-sex-modal-body').html(responce);
								$('#adult-sex-model').modal('show');
							}
				});
		}
		/*if (typeof activePoints[0] != 'undefined') {
			if (activePoints[0].label == 'Seasonal') {
			$('#seasonal').modal('show');
			}
			else if (activePoints[0].label == 'Resident') {
			$('#resident').modal('show');
			}
			else if (activePoints[0].label == 'Transients') {
			$('#transient').modal('show');
			}
		}*/
	}
);





var ctx_unknown_sex = document.getElementById('unknown-sex-pie-chart').getContext('2d');
 	window.myPie_unknown_sex = new Chart(ctx_unknown_sex).Pie(unknown_sex_pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });	
var legend_unknown_sex = myPie_unknown_sex.generateLegend();
$("#unknown-sex-legend").html(legend_unknown_sex);


$("#unknown-sex-pie-chart").click( 
	function(evt){
		var activePoints = myPie_unknown_sex.getSegmentsAtEvent(evt);
		var fromYear = $("#fromYear").val();
		if(activePoints[0] !== undefined){
			console.log(activePoints[0].label);
			$.ajax({
					url : "http://test.wildfins.org/Modules/Reporting/getPieChartSpecificData.cfm",
					method : "POST",
					data : {label : activePoints[0].label,fromYear:fromYear},
					success : function(responce){
								$('#unknown-sex-modal-title').text('All '+activePoints[0].label+'s');
								$('#unknown-sex-modal-body').html(responce);
								$('#unknown-sex-model').modal('show');
							}
				});
		}
		/*if (typeof activePoints[0] != 'undefined') {
			if (activePoints[0].label == 'Seasonal') {
			$('#seasonal').modal('show');
			}
			else if (activePoints[0].label == 'Resident') {
			$('#resident').modal('show');
			}
			else if (activePoints[0].label == 'Transients') {
			$('#transient').modal('show');
			}
		}*/
	}
);



}







handleGenerateGraph();

$('.dataToggle1').click(function(){

 $('.dataToggle1').not(this).each(function(){
	 id  = $(this).attr("id");
	$("#collapse1_"+id).removeClass('in');
 });

});

$('.dataToggle2').click(function(){

 $('.dataToggle2').not(this).each(function(){
	 id  = $(this).attr("id");
	$("#collapse2_"+id).removeClass('in');
 });

});

$('.dataToggle3').click(function(){

 $('.dataToggle3').not(this).each(function(){
	 id  = $(this).attr("id");
	$("#collapse3_"+id).removeClass('in');
 });

});
$('.dataToggle4').click(function(){

 $('.dataToggle4').not(this).each(function(){
	 id  = $(this).attr("id");
	$("#collapse_4"+id).removeClass('in');
 });

});

 /*$(document).on("click",".sighting-detail",function(){
     var form = $(this).closest("form");
     form.submit();
   });*/

      

/*$(function() {
  $('#bar-chart').highcharts({
    chart: {
      inverted: true,
      type: 'column',
      renderTo: 'container'
    },
    exporting: {
        enabled: false
    },
	title: {
          text: ''
    },
    xAxis: {
      categories: dolphinsCode,
      min: 0,
      scrollbar: {
        enabled: true
      },
      max: 3
    },
	legend: {
	  enabled: false
	},
	tooltip: {
          pointFormat: '<span style="color:{point.color}">\u25CF</span> {point.key}: <b>{point.y}</b><br/>'
        },
    series: [{
      data: dolphinsSeen
    }]
  });
});*/

});
function SubmitForm(id)
{
	document.getElementById(id).submit();
}
function ApplyPaginations(startmeup,num)
{
	$('input[name=startHereIndex'+num+']').val(startmeup);
	$('form[name=paginationform'+num+']').submit();
	//document.paginationform.formname.value = startmeup;
	//document.paginationform.submit();
}