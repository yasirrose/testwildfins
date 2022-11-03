$(document).ready(function() {
	//var BarHitss = BarHits;
	
	
/*=== get percentage for hits vs misses=======*/
var pieData = [

/******Blubber*****/
{
    value:  Math.round(BlubberTeflonVial),
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: 'BlubberTeflonVial'
},{
    value:  Math.round(BlubberCryovialRed),
    color: "#5AD3D1",
    highlight: "#5AD3f1",
    label: 'BlubberCryovialRed'
},{
    value:  Math.round(BlubberCryovialBlue),
    color: "#5AD3D1",
    highlight: "#5AD3f1",
    label: 'BlubberCryovialBlue'
}, 
/******Skins*****/
{
    value:  Math.round(getTotalSkinDMSO),
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'SkinDMSO'
},{
    value:  Math.round(getTotalSkinRNAlater),
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'SkinRNAlater'
},{
    value:  Math.round(getTotalSkinDCryovial),
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: 'SkinDCryovial'
}]; 



 


var ctx5 = document.getElementById('pie-chart').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<br><ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
   });
   
   
   var legend = myPie.generateLegend();
   $("#legend").html(legend);
   
   
   
   
   
 /*===== End Pie Chart =====*/


/*=========** Start Bar Chart **===========*/
/*
var res=[{
	value:Hit
	}]


var barChartData = {
    labels : ['3 meter','4 meter','5 meter ','6+ meter '],
	labelDisplay:['Hit','Miss','Hit','Miss'],
    datasets : [
       {
            data :getHitDistance
        },{
			
			data :getMissDistance
			}
    ]
};

var handleGenerateGraph = function(animationOption) {
	var animationOption = (animationOption) ? animationOption : false;
	var ctx2 = document.getElementById('bar-chart').getContext('2d');

    ctx2.canvas.height = 193;
	ctx2.labels =['Hit','Hit','Hit','Miss'];
     window.barChart = new Chart(ctx2).Bar(barChartData, {
        animation: animationOption,
		responsive : true
    });
	/* $("#bar-chart").click( 
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
	*/
    /*barChart.datasets[0].bars[0].fillColor = "orange"; 
	
	
 var ctx5 = document.getElementById('pie-chart').getContext('2d');
    window.myPie = new Chart(ctx5).Pie(pieData,{
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
		
		
    });
	
var legend = myPie.generateLegend();
$("#slegend").html(legend);*/
	

});




//});
//*/
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