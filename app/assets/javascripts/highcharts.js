$(document).ready(function(){

  $(".sk-folding-cube").hide();

  // show spinner on AJAX start
  $(document).ajaxStart(function(){
    $(".sk-folding-cube").show();
  });

  // hide spinner on AJAX stop
  $(document).ajaxStop(function(){
    $(".sk-folding-cube").hide();
  });

  var utcdate = function(data){

    var year = data[0];
    var month = data[1];
    var day = data[2];

    return Date.UTC(year, month, day)
  };

  var portfolio_id = $( '.hidden_portfolio_id' ).text();


  var request = $.ajax({
    url: `/portfolios/${portfolio_id}/fetch`,
    type: "GET"
  });

  request.done(function(response){

    // prepare data for pie chart
    var data_for_pie = [];

    for (var i=0; i < response["holdings"].length; i++){
    data_for_pie.push({name: response["holdings"][i]["symbol"],
        y: response["holdings"][i]["allocation"]})
    }

    for (var i=0; i < response["stocks"].length; i++){
      response["stocks"][i][0] = utcdate(response["stocks"][i][0]);
    }
    for (var i=0; i < response["nasdaq"].length; i++){
      response["nasdaq"][i][0] = utcdate(response["nasdaq"][i][0]);
    }
    for (var i=0; i < response["snp"].length; i++){
      response["snp"][i][0] = utcdate(response["snp"][i][0]);
    }
    for (var i=0; i < response["dji"].length; i++){
      response["dji"][i][0] = utcdate(response["dji"][i][0]);
    }
    for (var i = 0; i < response["articles"].length; i++){
      response["articles"][i][1] = jQuery.parseJSON(response["articles"][i][1])
    }

    // construct both charts
    startChart(response["stocks"],response["nasdaq"],response["snp"],response["dji"],response["articles"],response["title"]);
    startPieChart(data_for_pie)

  });


  request.fail(function(){
    console.log("request failed");

  });

});

var startPieChart = function(data_for_pie){
  $(function () {
  $('#pie-chart').highcharts({
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      type: 'pie'
    },
    title: {
      text: 'Look I am a Pie chart for your portfolio'
    },
    credits: {
      enabled: false
  },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.percentage:.1f} %',
          style: {
            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
          }
        }
      }
    },
    series: [{
      name: 'Brands',
      colorByPoint: true,
      data: data_for_pie


      // }, {
      //     name: 'Chrome',
      //     y: 24.03,
      //     sliced: true,
      //     selected: true
      // }, {
      //     name: 'Firefox',
      //     y: 10.38
      // }, {
      //     name: 'Safari',
      //     y: 4.77
      // }, {
      //     name: 'Opera',
      //     y: 0.91
      // }, {
      //     name: 'Proprietary or Undetectable',
      //     y: 0.2



    }]
  });
  });
};


var startChart = function(stocks,nasdaq,snp,dji,articles,title){
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
          title : {
            text : title
          },
          credits: {
           enabled: false
          },
          plotOptions:{
                flags:{
                    point:{
                    events:{
                        click:function(e){
                            e.preventDefault();

                            var url = this.url;

                            window.open(url,'_blank');
                        }
                    }
                    }
                }
            },
            series: seriesOptions
        }

      );
    }
    $.each(names, function (i, name) {
        seriesOptions[i] = {
            name: name,
            data: data[i],
            id: i + 1
        // As we're loading the data asynchronously, we don't know what order it will arrive. So
        // we keep a counter and create the chart when all the data is loaded.
        // seriesCounter += 1;
        // if (seriesCounter === names.length) {
        //     createChart();
        // }
      }
    });
    for (var i = 0; i < articles.length; i++){
      for (var j =0; j <articles[i][1].response.docs.length; j++){
        seriesOptions.push({
                type: 'flags',
                data: [{
                  x : Date.parse(articles[i][1].response.docs[j].pub_date),
                  title: articles[i][0],
                  url: articles[i][1].response.docs[j].web_url
                }],
                onSeries: 1
                })
      }
    }
    createChart();
  });

};
