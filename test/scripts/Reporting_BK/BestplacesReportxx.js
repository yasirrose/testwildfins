var primary		= '#2184DA',
    primaryLight= '#60A1DA',
    primaryDark	= '#1e77c5',
    info		= '#38AFD3',
    infoLight	= '#6FBDD5',
    infoDark	= '#2d8ca9',
    success		= '#17B6A4',
    successLight= '#59C2B7',
    successDark	= '#129283',
    warning		= '#fcaf41',
    warningLight= '#EEBD77',
    warningDark	= '#ca8c34',
    inverse		= '#3C454D',
    grey		= '#aab3ba',
    purple		= '#9b59b6',
    purpleLight	= '#BE93D0',
    purpleDark	= '#7c4792',
    danger      = '#F04B46';

var handleMorrisDonusChart = function() {
    "use strict";
    
    Morris.Donut({
        element: 'donut-chart',
        data: [
            {label: 'Jam', value: 25 },
            {label: 'Frosted', value: 40 },
            {label: 'Custard', value: 25 },
            {label: 'Sugar', value: 10 }
        ],
        formatter: function (y) { return y + "%" },
        resize: true,
        colors: [inverse, warning, danger, grey]
    });
};
handleMorrisDonusChart();

/*var handleDonutChart = function () {
    "use strict";
    
    if ($('#donut-chart').length !== 0) {
        var data = [];
        var series = 3;
        var colorArray = [inverse, primary, grey];
        var nameArray = ['Series 1', 'Series 2', 'Series 3', 'Series 4', 'Series 5'];
        var dataArray = [20,14,12,31,23];
        for( var i = 0; i<series; i++)
        {
            data[i] = { label: nameArray[i], data: dataArray[i], color: colorArray[i] };
        }

        $.plot($("#donut-chart"), data, 
        {
            series: {
                pie: { 
                    innerRadius: 0.5,
                    show: true,
                    combine: {
                        color: '#999',
                        threshold: 0.2
                    }
                }
            },
            grid:{borderWidth:0, hoverable: true, clickable: true}
        });
    }
};
handleDonutChart();*/