$( document ).ready(function() {

  var portfolio_id = $( '.hidden_portfolio_id' ).text();

  var request = $.ajax({
	url: `/portfolios/${portfolio_id}/fetch`,
	type: "GET"
  });

  request.done(function(response){
  	var data_for_pie = [];

  	for (var i=0; i < response["holdings"].length; i++){
		data_for_pie.push({name: response["holdings"][i]["symbol"],
				y: response["holdings"][i]["allocation"]})
  	}

  	startPieChart(data_for_pie)

  });

});


var startPieChart = function(data_for_pie){
  $(function () {
	$('#container').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: 'Look I am a Pie chart for your portfolio'
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



