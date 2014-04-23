$(function () {
    $('#chart').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Student Mastery Levels'
        },
        subtitle: {
            text: '(Percentages)'
        },
        xAxis: {
            categories: ['Module01', 'Module02', 'Module03', 'Module04', 'Module05'],
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Mastery (percent)',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ' percent'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 100,
            floating: true,
            borderWidth: 1,
            backgroundColor: '#FFFFFF',
            shadow: true
        },
        credits: {
            enabled: false
        },
        series: [{
            name: 'Student 01',
            data: [0.78, 0.8, 0.6, 0.2, 0]
        }, {
            name: 'Student 02',
            data: [0.9, 0.83, 0.4, 0.65, 0]
        }, {
            name: 'Student 03',
            data: [0.77, 0.86, 0.51, 0.23, 0.75]
        }]
    });
});