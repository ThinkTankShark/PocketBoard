$(function () {
    $.getJSON('https://www.highcharts.com/samples/data/jsonp.php?filename=new-intraday.json&callback=?', function (data) {

        // create the chart
        $('#container').highcharts('StockChart', {

            xAxis: {
                gapGridLineWidth: 0
            },

            yAxis: {
                gridLineWidth: 0,
                minorGridLineWidth: 0
              },

            rangeSelector : {
                buttons : [{
                    type : 'hour',
                    count : 1,
                    text : '1h'
                }, {
                    type : 'day',
                    count : 1,
                    text : '1D'
                }, {
                    type : 'all',
                    count : 1,
                    text : 'All'
                }],
                selected : 1,
                inputEnabled : false
            },

            series : [{
                name : 'AAPL',
                type: 'line',
                data : data,
                gapSize: 5,
                tooltip: {
                    valueDecimals: 2
                },

                threshold: null
            }]
        });
    });
    // Load the fonts
    Highcharts.createElement('link', {
       href: 'https://fonts.googleapis.com/css?family=Signika:400,700',
       rel: 'stylesheet',
       type: 'text/css'
    }, null, document.getElementsByTagName('head')[0]);

    Highcharts.theme = {
       // colors: ["#f45b5b", "#8085e9", "#8d4654", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
       //    "#55BF3B", "#DF5353", "#7798BF", "#aaeeee", null],
       chart: {
          backgroundColor: null,
          style: {
             fontFamily: "Montserrat, Helvetica Neue"
          }
       },
       tooltip: {
          borderWidth: 0
       },

       plotOptions: {
          series: {
             shadow: true
          },
          map: {
             shadow: true
          }
       },
       // Highstock specific

       // // General
       // background2: '#E0E0E8'
    };

    // Apply the theme
    Highcharts.setOptions(Highcharts.theme);
});
