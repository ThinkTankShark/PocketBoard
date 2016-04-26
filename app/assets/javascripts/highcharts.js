$(document).ready(function(){
  var utcdate = function(data){

    var year = data[0];
    var month = data[1];
    var day = data[2];

    return Date.UTC(year, month, day)
  };
  for (var i=0; i < stocks.length; i++){
    stocks[i][0] = utcdate(stocks[i][0]);
  }
  for (var i=0; i < nasdaq.length; i++){
    nasdaq[i][0] = utcdate(nasdaq[i][0]);
  }
  for (var i=0; i < snp.length; i++){
    snp[i][0] = utcdate(snp[i][0]);
  }
  for (var i=0; i < dji.length; i++){
    dji[i][0] = utcdate(dji[i][0]);
  }
  startChart();

});




// var addChart = function(){
//   $(function () {
//      // Create the chart
//      $('#chart').highcharts('StockChart', {
//          rangeSelector : {
//              selected : 5
//          },
//          title : {
//              text : title
//          },
//          series : [{
//              name : 'Portfolio',
//              data : stocks,
//              tooltip: {
//                  valueDecimals: 2
//              }
//          }]
//      });
//   });
// }

var startChart = function(){
  $(function () {
      var seriesOptions = [],
          seriesCounter = 0,
          names = ['Portfolio','NASDAQ', 'SNP', 'DJI'],
          data = [stocks,nasdaq,snp,dji];
      /**
       * Create the chart when all data is loaded
       * @returns {undefined}
       */
      function createChart() {
          $('#chart').highcharts('StockChart', {
              rangeSelector: {
                  selected: 4
              },
              yAxis: {
                  labels: {
                      formatter: function () {
                          return (this.value > 0 ? ' + ' : '') + this.value + '%';
                      }
                  },
                  plotLines: [{
                      value: 0,
                      width: 2,
                      color: 'silver'
                  }]
              },
              plotOptions: {
                  series: {
                      compare: 'percent'
                  }
              },
              tooltip: {
                  pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                  valueDecimals: 2
              },
              series: seriesOptions
          });
      }
    $.each(names, function (i, name) {
        seriesOptions[i] = {
            name: name,
             data: data[i]
              },
              {
                type : 'flags',
                data : [{
               x : Date.UTC(2016, 1, 2),
                    title : 'C',
                    text : 'Stocks fall on Greece, rate concerns; US dollar dips'
                }, {
                    x : Date.UTC(2016, 2, 2),
                    title : 'D',
                    text : 'Zimbabwe ditches \'worthless\' currency for the US dollar '
                }, {
                    x : Date.UTC(2016, 1, 3),
                    title : 'E',
                    text : 'US Dollar Declines Over the Week on Rate Timeline'
                }, {
                    x : Date.UTC(2016, 2, 3),
                    title : 'F',
                    text : 'Greek Negotiations Take Sharp Turn for Worse, US Dollar set to Rally '
                }, {
                    x : Date.UTC(2016, 2, 29),
                    title : 'G',
                    text : 'Euro records stunning reversal against dollar'
                }, {
                    x : Date.UTC(2016, 3, 30),
                    title : 'H',
                    text : 'Surging US dollar curbs global IT spend'
                }],
                onSeries : 'dataseries',
                shape : 'circlepin',
                width : 16

      };
    });
    createChart();
  });
};
