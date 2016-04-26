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
  addChart();

});




var addChart = function(){
  $(function () {
     // Create the chart
     $('#chart').highcharts('StockChart', {
         rangeSelector : {
             selected : 5
         },
         title : {
             text : title
         },
         series : [{
             name : 'Portfolio',
             data : stocks,
             tooltip: {
                 valueDecimals: 2
             }
         }]
     });
  });
}
