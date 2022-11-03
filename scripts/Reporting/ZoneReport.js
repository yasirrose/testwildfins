$(function () {
	
	var ticksLabel = [];

    var monthNames = [ "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
            "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" ];
    
    function diff(from, to) {
        var arr = [];
        var datFrom = new Date('1 ' + from);
        var datTo = new Date('1 ' + to);
        var fromYear =  datFrom.getFullYear();
        var toYear =  datTo.getFullYear();
        var diffYear = (12 * (toYear - fromYear)) + datTo.getMonth();
        for (var i = datFrom.getMonth(); i <= diffYear; i++) {
           xx = Math.floor(fromYear+(i/12));
           arr.push(monthNames[i%12] + "'" + xx.toString().substr(2,2));
        }
        return arr;
    }

ticksLabel = diff(dtStart, dtEnd);

console.log(ticksLabel);
	
 
	
    Highcharts.chart('container', {

        chart: {
            type: 'column'
        },

        title: {
            text: 'Zone Report'
        },

        xAxis: {
            categories: ticksLabel,
			 max: 12
        },

        yAxis: {
            allowDecimals: false,
            min: 0,
			max : 240,
			tickInterval: 1,
            title: {
                text: 'Zones'
            }
        },

      /*  tooltip: {
            formatter: function () {
                return '<b>' + this.x + '</b><br/>' +
                    this.series.name + ': ' + this.y + '<br/>' +
                    'Total: ' + this.point.stackTotal;
            }
        },
		
		
*/

     defs: {
        patterns: [{
            'id': 'custom-ML',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#FF0000',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-BR',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#FFFF99',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-NorthIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#FF9900',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-NorthCentralIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#CCFFCC',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-SouthCentralIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#CCFFFF',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-SouthIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke:  '#CC99FF',
    	        strokeWidth: 3
            }
        }]
    },
        scrollbar: {
        	enabled: false
    	},
		
        plotOptions: {
			 pointWidth: 10,
            column: {
                stacking: 'normal'
            }
        },

        series: [
				 
				 
				 
/*		{
            name: 'IR',
            data: [204, 204, 204, 204, 204,204, 204, 204, 204, 204,204, 204, 204, 204, 204,204, 204, 204, 204, 204],
            stack: 'male',
			 color: '#3366FF'
        },
        */
		
        
		
		
		/*IR NorthCentralIndianRiver Start*/
		
			
		
		{
			showInLegend: false, 
			stack : 'male',	 
            name: '',
            data: qyearlyZones[12],
			color: 'url(#custom-NorthCentralIndianRiver)'
			},	
			
		
		{
			stack : 'male',	 
            name: 'IR (North-Central Indian River)',
            data: qyearlyZones[10],
			color : '#CCFFCC'
        },
		
		{
			showInLegend: false, 
			stack : 'male',	 
            name: '',
            data: qyearlyZones[11],
			color: 'url(#custom-NorthCentralIndianRiver)'
        },
		
		{
			showInLegend: false, 
			stack : 'male',	 
            name: '',
            data: qyearlyZones[13],
			color: 'url(#custom-NorthCentralIndianRiver)'
        },
		
		
		
		

		
		
		
		
	  {
		  showInLegend: false, 
            name: '',
            data: qyearlyZones[9],
            stack: 'male',
            color: 'rgba(255, 255, 255, 0.50)'
        },
		
		
		
		/*IR NorthCentralIndianRiver END*/
		
		
		
		
		

		

		
				/*BR Start*/
		
       	{
			showInLegend: false, 
			stack : 'female',	 
            name: '',
            data: qyearlyZones[6],
			color: 'url(#custom-BR)'
        },	
			
		
		{
			
			stack : 'female',	 
            name: 'BR (Banana River)',
            data: qyearlyZones[4],
			color : '#FFFF99'
        },
		
		{
			showInLegend: false, 
			stack : 'female',	 
            name: '',
            data: qyearlyZones[5],
			color: 'url(#custom-BR)'
        },
		
		{
			showInLegend: false, 
			stack : 'female',	 
            name: '',
            data: qyearlyZones[7],
			color: 'url(#custom-BR)'
        }
		
		
		

		/*BR End	*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		, {
			showInLegend: false, 
            name: '',
            data: qyearlyZones[8],
            stack: 'female',
            color: 'rgba(255, 255, 255, 0.50)'
        }, 
		
		
				
		/*ML Start*/
			
		{
			showInLegend: false, 
			stack : 'female',	 
            name: '',
            data: qyearlyZones[2],
			color: 'url(#custom-ML)'
        },	
			
		
		{
			stack : 'female',	 
            name: 'ML (Mosquito Lagoon)',
            data: qyearlyZones[0],
			color : '#FF0000'
        },
		
		{
			showInLegend: false, 
			stack : 'female',	 
            name: '',
            data:  qyearlyZones[1],
			color: 'url(#custom-ML)'
        },
		
		{
			showInLegend: false, 
			stack : 'female',	 
            name: '',
            data: qyearlyZones[3],
			color: 'url(#custom-ML)'
        }
		
	  	/*ML End	*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		]
    });
	
	/*Current Month Graph*/
	 lab = moment().format('MMMM YYYY');
	  console.log(qCurrentMonthZones[0].ir_range);

    Highcharts.chart('currentmonthzones', {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Zone Report'
        },
        xAxis: {
			//reversed: true,
            categories: [lab]
        },
        yAxis: {
			//reversed: true,
            min: 0,
			max : 300,
            title: {
                text: 'Zones'
            },
            stackLabels: {
                enabled: true,
                style: {
                    fontWeight: 'bold',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                }
            }
        },
		
		defs: {
        patterns: [{
            'id': 'custom-ML',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#FF0000',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-BR',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#FFFF99',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-NorthIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#FF9900',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-NorthCentralIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#CCFFCC',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-SouthCentralIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke: '#CCFFFF',
    	        strokeWidth: 3
            }
        },{
            'id': 'custom-SouthIndianRiver',
            'path': {
                d: 'M 0 0 L 10 10 M 9 -1 L 11 1 M -1 9 L 1 11',
	            stroke:  '#CC99FF',
    	        strokeWidth: 3
            }
        }]
    },
		
        legend: {
            align: 'right',
            x: -30,
            verticalAlign: 'top',
            y: 25,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
            borderColor: '#CCC',
            borderWidth: 1,
            shadow: false
        },
        tooltip: {
           
        },
        plotOptions: {
             column: {
                stacking: 'normal'
            }
        },
        series: [
		
		/*ML Start*/
			
		{
			showInLegend: false,  
			stack : 'ML',	 
            name: '',
            data: [qCurrentMonthZones[0].ml_end_space],
			color: 'url(#custom-ML)'
        },	
			
		
		{
			stack : 'ML',	 
            name: 'ML (Mosquito Lagoon)',
            data: [qCurrentMonthZones[0].ml_bar],
			color : '#FF0000'
        },
		
		{
			showInLegend: false,  
			stack : 'ML',	 
            name: '',
            data: [qCurrentMonthZones[0].ml_start_space],
			color: 'url(#custom-ML)'
        },
		
		{
			showInLegend: false,  
			stack : 'ML',	 
            name: '',
            data: [qCurrentMonthZones[0].ml_full_space],
			color: 'url(#custom-ML)'
        },
		
	  	/*ML End	*/
		
		
		/*BR Start*/
		
       	{
			showInLegend: false,  
			stack : 'BR',	 
            name: '',
            data: [qCurrentMonthZones[0].br_end_space],
			color: 'url(#custom-BR)'
        },	
			
		
		{
			
			stack : 'BR',	 
            name: 'BR (Banana River)',
            data: [qCurrentMonthZones[0].br_bar],
			color : '#FFFF99'
        },
		
		{
			showInLegend: false, 
			stack : 'BR',	 
            name: '',
            data: [qCurrentMonthZones[0].br_start_space],
			color: 'url(#custom-BR)'
        },
		
		{
			showInLegend: false, 
			stack : 'BR',	 
            name: '',
            data: [qCurrentMonthZones[0].br_full_space],
			color: 'url(#custom-BR)'
        },
		
		
		
		{
			showInLegend: false, 
			stack : 'BR',	 
            name: '',
            data: [72],
			color : 'rgba(255, 255, 255, 0.50)'
        },
		
		/*BR End	*/
		
		
		/*IR NorthIndianRiver Start*/
			
		
		{
			showInLegend: false, 
			stack : 'NorthIndianRiver',	 
            name: 'IR (North Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_northindianriver_end_space],
			color: 'url(#custom-NorthIndianRiver)'
        },	
			
		
		{
			stack : 'NorthIndianRiver',	 
            name: 'IR (North Indian River)',
            data: [qCurrentMonthZones[0].ir_northindianriver_bar],
			color : '#FF9900'
        },
		
		{
			showInLegend: false, 
			stack : 'NorthIndianRiver',	 
            name: 'IR (North Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_northindianriver_start_space],
			color: 'url(#custom-NorthIndianRiver)'
        },
		
		{
			showInLegend: false, 
			stack : 'NorthIndianRiver',	 
            name: 'IR (North Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_northindianriver_full_space],
			color: 'url(#custom-NorthIndianRiver)'
        },
		
		
		
		
		{
			showInLegend: false, 
			stack : 'NorthIndianRiver',	 
            name: '',
            data: [32],
			color : 'rgba(255, 255, 255, 0.50)'
        },
		
		
		
		/*IR NorthIndianRiver END*/
		
		
		
		
		/*IR NorthCentralIndianRiver Start*/
		
			
		
		{
			showInLegend: false, 
			stack : 'NorthCentralIndianRiver',	 
            name: 'IR (North-Central Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_northcentralindianriver_end_space],
			color: 'url(#custom-NorthCentralIndianRiver)'
			},	
			
		
		{
			stack : 'NorthCentralIndianRiver',	 
            name: 'IR (North-Central Indian River)',
            data: [qCurrentMonthZones[0].ir_northcentralindianriver_bar],
			color : '#CCFFCC'
        },
		
		{
			showInLegend: false, 
			stack : 'NorthCentralIndianRiver',	 
            name: 'IR (North-Central Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_northcentralindianriver_start_space],
			color: 'url(#custom-NorthCentralIndianRiver)'
        },
		
		{
			showInLegend: false, 
			stack : 'NorthCentralIndianRiver',	 
            name: 'IR (North-Central Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_northcentralindianriver_full_space],
			color: 'url(#custom-NorthCentralIndianRiver)'
        },
		
		
		
		
		
		{
			showInLegend: false, 
			stack : 'NorthCentralIndianRiver',	 
            name: '',
            data: [104],
			color : 'rgba(255, 255, 255, 0.50)'
        },
		
		
		
		/*IR NorthCentralIndianRiver END*/
		
		
		/*IR SouthCentralIndianRiver Start*/
		
				
				
		{
			showInLegend: false, 
			stack : 'SouthCentralIndianRiver',	 
            name: 'IR (South-Central Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_southcentralindianriver_end_space],
			color: 'url(#custom-SouthCentralIndianRiver)'
        },	
			
		
		{
			stack : 'SouthCentralIndianRiver',	 
            name: 'IR (South-Central Indian River)',
            data: [qCurrentMonthZones[0].ir_southcentralindianriver_bar],
			color : '#CCFFFF'
        },
		
		{
			showInLegend: false, 
			stack : 'SouthCentralIndianRiver',	 
            name: 'IR (South-Central Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_southcentralindianriver_start_space],
			color: 'url(#custom-SouthCentralIndianRiver)'
        },
		
		{
			showInLegend: false, 
			stack : 'SouthCentralIndianRiver',	 
            name: 'IR (South-Central Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_southcentralindianriver_full_space],
			color: 'url(#custom-SouthCentralIndianRiver)'
        },
		
		
		
		
		
		
		
		{
			showInLegend: false, 
			stack : 'SouthCentralIndianRiver',	 
            name: '',
            data: [135],
			color : 'rgba(255, 255, 255, 0.50)'
        },
		
		
		
		
		
		
		/*IR SouthCentralIndianRiver END*/
		
	
		
					
		{
			showInLegend: false, 
			stack : 'IR & SLR',	 
            name: 'IR & SLR (South Indian River) Missed',
            data: [qCurrentMonthZones[0].ir_southindianriver_end_space],
			color: 'url(#custom-SouthIndianRiver)'
        },	
			
		
		{
			stack : 'IR & SLR',	 
            name: 'IR & SLR (South Indian River)',
            data: [qCurrentMonthZones[0].ir_southindianriver_bar],
			color : '#CC99FF'
        },
		
		{
			showInLegend: false,  
			stack : 'IR & SLR',	 
            name: 'I',
            data: [qCurrentMonthZones[0].ir_southindianriver_start_space],
			color: 'url(#custom-SouthIndianRiver)'
        },
		
		{
			showInLegend: false,  
			stack : 'IR & SLR',	 
            name: '',
            data: [qCurrentMonthZones[0].ir_southindianriver_full_space],
			color: 'url(#custom-SouthIndianRiver)'
        },
		
		
		{
			showInLegend: false,  
			stack : 'IR & SLR',	 
            name: '',
            data: [168],
			color : 'rgba(255, 255, 255, 0.50)'
        }
		
		
		]
    });
});
	