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

/*var barChartData_fromYear = {
    labels : ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
    datasets : [
        {
            
            data :res_fromYear
        }
    ]
};*/

/*var barChartData_toYear = {
    labels : ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
    datasets : [
        {
            
            data :res_toYear
        }
    ]
};*/

   
var pieData_fromYear = [ {
    value: summary2_fromYear[0],
   color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Resident'
}, {
    value: summary2_fromYear[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Seasonal'
}, {
    value: summary2_fromYear[2],
     color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Transients'
}];



var pieData_toYear = [ {
    value: summary2_toYear[0],
   color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'Resident'
}, {
    value: summary2_toYear[1],
    color: "#FDB45C",
    highlight: "#FFC870",
    label: 'Seasonal'
}, {
    value: summary2_toYear[2],
     color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'Transients'
}];

  

var handleGenerateGraph_fromYear = function(animationOption) {
	var animationOption = (animationOption) ? animationOption : false;
	var ctx2_fromYear = document.getElementById('bar-chart_fromYear').getContext('2d');
	var ctx2_toYear = document.getElementById('bar-chart_toYear').getContext('2d');

    /*ctx2_fromYear.canvas.height = 193;
     window.barChart_fromYear = new Chart(ctx2_fromYear).Bar(barChartData_fromYear, {
        animation: animationOption,
		responsive : true
    });*/
	
	/*ctx2_toYear.canvas.height = 193;
     window.barChart_toYear = new Chart(ctx2_toYear).Bar(barChartData_toYear, {
        animation: animationOption,
		responsive : true
    });*/


	document.getElementById("bar-chart_fromYear").onclick = function(evt){
            var activePoints = chart1.getElementsAtEvent(evt);
            var firstPoint = activePoints[0];
			if(firstPoint !== undefined){
					/*var label = chart1.data.labels[firstPoint._index];
					var value = chart1.data.datasets[firstPoint._datasetIndex].data[firstPoint._index];
					alert(label + ": " + value);*/
					startYear = $("#fromYear").val();
					endYear = $("#toYear").val();	
					$.ajax({
						url:application_root+"Reporting.cfc?method=getRollCallGrapghMonthfromYear",
						type : "get",
						data : {monthName : chart1.data.labels[firstPoint._index],fromYear:startYear,toYear:endYear},
						success:function(data) {
						console.log(data);
						res_fromYear = JSON.parse(data);
						console.log(res_fromYear);
						count = Object.keys(res_fromYear.DATA).length;
						console.log(count);
						var j ; 
						$('#tbl_row').html('');
						for (i=0; i < count; i++) {
							j= i + 1;
							console.log(i);
							if(res_fromYear.DATA[i][8] === null) { sex = 'N/A';} else {sex = res_fromYear.DATA[i][8];}
							$('#tbl_row').append('<tr><td width="80">'+j+'</td><td width="100">'+res_fromYear.DATA[i][7]+'</td><td width="120"><form action="/?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank"><input type="hidden" name="project_id" value="'+res_fromYear.DATA[i][1]+'"><input type="hidden" name="sight_id" value="'+res_fromYear.DATA[i][0]+'"><span class="sighting-detail">'+res_fromYear.DATA[i][0]+'</span></form></td><td width="250">'+res_fromYear.DATA[i][6]+'</td><td width="50">'+sex+'</td></tr>');
							}
							$('#month_title').html('List of Dolphins for ' + chart1.data.labels[firstPoint._index] + ' ' + startYear);
							$('#summary1').modal('show');
							
							
						}
					});
				}

        };
		
		
		
		
		document.getElementById("bar-chart_toYear").onclick = function(evt){
            var activePoints = chart2.getElementsAtEvent(evt);
            var firstPoint = activePoints[0];
			if(firstPoint !== undefined){
					/*var label = chart1.data.labels[firstPoint._index];
					var value = chart1.data.datasets[firstPoint._datasetIndex].data[firstPoint._index];
					alert(label + ": " + value);*/
					startYear = $("#fromYear").val();
					endYear = $("#toYear").val();	
					$.ajax({
						url:application_root+"Reporting.cfc?method=getRollCallGrapghMonthtoYear",
						type : "get",
						data : {monthName : chart2.data.labels[firstPoint._index],fromYear:startYear,toYear:endYear},
						success:function(data) {
						console.log(data);
						res_toYear = JSON.parse(data);
						console.log(res_toYear);
						count = Object.keys(res_toYear.DATA).length;
						console.log(count);
						var j ; 
						$('#tbl_row').html('');
						for (i=0; i < count; i++) {
							j= i + 1;
							console.log(i);
							if(res_toYear.DATA[i][8] === null) { sex = 'N/A';} else {sex = res_toYear.DATA[i][8];}
							$('#tbl_row').append('<tr><td width="80">'+j+'</td><td width="100">'+res_toYear.DATA[i][7]+'</td><td width="120"><form action="/?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank"><input type="hidden" name="project_id" value="'+res_toYear.DATA[i][1]+'"><input type="hidden" name="sight_id" value="'+res_toYear.DATA[i][0]+'"><span class="sighting-detail">'+res_toYear.DATA[i][0]+'</span></form></td><td width="250">'+res_toYear.DATA[i][6]+'</td><td width="50">'+sex+'</td></tr>');
							}
							$('#month_title').html('List of Dolphins for ' + chart1.data.labels[firstPoint._index] + ' ' + startYear);
							$('#summary1').modal('show');
							
							
						}
					});
				}

        };
		
		
		
		
		
	
/*	 $("#bar-chart_fromYear").click( 
		function(evt){
			var activeBars = barChart_fromYear.getBarsAtEvent(evt);
			if (typeof activeBars[0] != 'undefined') {
				startYear = $("#fromYear").val();
				endYear = $("#toYear").val();	
			$.ajax({
				url:application_root+"Reporting.cfc?method=getRollCallGrapghMonthfromYear",
				type : "get",
				data : {monthName : activeBars[0].label,fromYear:startYear,toYear:endYear},
				success:function(data) {
				console.log(data);
				res_fromYear = JSON.parse(data);
				console.log(res_fromYear);
				count = Object.keys(res_fromYear.DATA).length;
				console.log(count);
				var j ; 
				$('#tbl_row').html('');
				for (i=0; i < count; i++) {
					j= i + 1;
					console.log(i);
					if(res_fromYear.DATA[i][8] === null) { sex = 'N/A';} else {sex = res_fromYear.DATA[i][8];}
					$('#tbl_row').append('<tr><td width="80">'+j+'</td><td width="100">'+res_fromYear.DATA[i][7]+'</td><td width="120"><form action="/?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank"><input type="hidden" name="project_id" value="'+res_fromYear.DATA[i][1]+'"><input type="hidden" name="sight_id" value="'+res_fromYear.DATA[i][0]+'"><span class="sighting-detail">'+res_fromYear.DATA[i][0]+'</span></form></td><td width="250">'+res_fromYear.DATA[i][6]+'</td><td width="50">'+sex+'</td></tr>');
					}
					$('#month_title').html('List of Dolphins for ' + activeBars[0].label + ' ' + startYear);
					$('#summary1').modal('show');
					
				    
				}
			});
		}
		}
	);*/
	
	
	
	
	
	/*$("#bar-chart_toYear").click( 
		function(evt){
			var activeBars = barChart_fromYear.getBarsAtEvent(evt);
			if (typeof activeBars[0] != 'undefined') {
				startYear = $("#fromYear").val();
				endYear = $("#toYear").val();	
			$.ajax({
				url:application_root+"Reporting.cfc?method=getRollCallGrapghMonthtoYear",
				type : "get",
				data : {monthName : activeBars[0].label,fromYear:startYear,toYear:endYear},
				success:function(data) {
				console.log(data);
				res_toYear = JSON.parse(data);
				console.log(res_toYear);
				count = Object.keys(res_toYear.DATA).length;
				console.log(count);
				var j ; 
				$('#tbl_row').html('');
				for (i=0; i < count; i++) {
					j= i + 1;
					console.log(i);
					if(res_toYear.DATA[i][8] === null) { sex = 'N/A';} else {sex = res_toYear.DATA[i][8];}
					$('#tbl_row').append('<tr><td width="80">'+j+'</td><td width="100">'+res_toYear.DATA[i][7]+'</td><td width="120"><form action="/?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank"><input type="hidden" name="project_id" value="'+res_toYear.DATA[i][1]+'"><input type="hidden" name="sight_id" value="'+res_toYear.DATA[i][0]+'"><span class="sighting-detail">'+res_toYear.DATA[i][0]+'</span></form></td><td width="250">'+res_toYear.DATA[i][6]+'</td><td width="50">'+sex+'</td></tr>');
					}
					$('#month_title').html('List of Dolphins for ' + activeBars[0].label + ' ' + endYear);
					$('#summary1').modal('show');
					
				    
				}
			});
		}
		}
	);*/    
	
	/*barChart.datasets[0].bars[0].fillColor = "green"; */
     //barChart_fromYear.datasets[0].bars[0].fillColor = "orange"; 
    // barChart_toYear.datasets[0].bars[0].fillColor = "red"; 
	 /*barChart.datasets[0].bars[3].fillColor = "yellow"; 
	 barChart.datasets[0].bars[4].fillColor = "#69D2E7"; 
	 barChart.datasets[0].bars[5].fillColor = "#A7DBDB"; 
	 barChart.datasets[0].bars[6].fillColor = " #28ABE3"; 
	 barChart.datasets[0].bars[7].fillColor = "#1FDA9A"; 
	 barChart.datasets[0].bars[8].fillColor = "#FF4C65"; 
	 barChart.datasets[0].bars[9].fillColor = "#6E9ECF"; 
	 barChart.datasets[0].bars[10].fillColor = "#75EB00"; 
	 barChart.datasets[0].bars[11].fillColor = "#9B539C"; */
   // barChart_fromYear.update();
	//barChart_toYear.update();
	
 var ctx5 = document.getElementById('pie-chart-fromYear').getContext('2d');
    window.myPie_fromYear = new Chart(ctx5).Pie(pieData_fromYear,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });
	
	
	 $("#pie-chart-fromYear").click( 
                        function(evt){
                            var activePoints_fromYear = myPie_fromYear.getSegmentsAtEvent(evt);
							if (typeof activePoints_fromYear[0] != 'undefined') {
								//if (activePoints_fromYear[0].label == 'Seasonal') {
									startYear = $("#fromYear").val();
									endYear = $("#toYear").val();
									$.ajax({
											url:application_root+"Reporting.cfc?method=getRollCallPieGraphSliceDataFromYear",
											type : "post",
											data : {label : activePoints_fromYear[0].label,fromYear:startYear,toYear:endYear},
											success : function(responce){
													$('#pieslice').html(responce);
													$('#seasonal').modal('show');
													console.log(responce);
												}	
										});
								}
                        }
                    );                  
	
	
var legend = myPie_fromYear.generateLegend();
$("#legend-fromYear").html(legend);





var ctx5 = document.getElementById('pie-chart-toYear').getContext('2d');
    window.myPie_toYear = new Chart(ctx5).Pie(pieData_toYear,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
    });
	
	
	 $("#pie-chart-toYear").click( 
                        function(evt){
                            var activePoints_toYear = myPie_toYear.getSegmentsAtEvent(evt);
							if (typeof activePoints_toYear[0] != 'undefined') {
								//if (activePoints_fromYear[0].label == 'Seasonal') {
									startYear = $("#fromYear").val();
									endYear = $("#toYear").val();
									$.ajax({
											url:application_root+"Reporting.cfc?method=getRollCallPieGraphSliceDataToYear",
											type : "post",
											data : {label : activePoints_toYear[0].label,fromYear:startYear,toYear:endYear},
											success : function(responce){
													$('#pieslice').html(responce);
													$('#seasonal').modal('show');
													console.log(responce);
												}	
										});
								}
                        }
                    );                 
	
	
var legend = myPie_toYear.generateLegend();
$("#legend-toYear").html(legend);



	

}

handleGenerateGraph_fromYear();

$('.dataToggle').click(function(){

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