$(function () {

        // Create the chart
        $('#test').highcharts('StockChart', {


            rangeSelector : {
                selected : 5
            },

            title : {
                text : 'AAPL Stock Price'
            },

            series : [{
                name : 'AAPL',
                data : [ [Date.UTC(2015,2,10),1], 
                    [Date.UTC(2015,2,14), 2],
                  [Date.UTC(2015,2,15), 3],
                   [Date.UTC(2015,2,16), 4]
                  ],
                tooltip: {
                    valueDecimals: 2
                }
            }]
        });
        
});


var utcdate = function(data){

    var year = data["year"];
    var month = data["month"];
    var day = data["day"];

    return Date.UTC(year, month, day)
};



// $(function () {
//     $.getJSON('https://www.highcharts.com/samples/data/jsonp.php?filename=new-intraday.json&callback=?', function (data) {

//         // create the chart
//         $('#test').highcharts('StockChart', {

//             xAxis: {
//                 gapGridLineWidth: 0
//             },

//             yAxis: {
//                 gridLineWidth: 0,
//                 minorGridLineWidth: 0
//               },

//             rangeSelector : {
//                 buttons : [{
//                     type : 'hour',
//                     count : 1,
//                     text : '1h'
//                 }, {
//                     type : 'day',
//                     count : 1,
//                     text : '1D'
//                 }, {
//                     type : 'all',
//                     count : 1,
//                     text : 'All'
//                 }],
//                 selected : 1,
//                 inputEnabled : false
//             },

//             series : [{
//                 name : 'AAPL',
//                 type: 'line',
//                 data : data,
//                 gapSize: 5,
//                 tooltip: {
//                     valueDecimals: 2
//                 },

//                 threshold: null
//             }]
//         });
//     });
//     // Load the fonts
//     Highcharts.createElement('link', {
//        href: 'https://fonts.googleapis.com/css?family=Signika:400,700',
//        rel: 'stylesheet',
//        type: 'text/css'
//     }, null, document.getElementsByTagName('head')[0]);

//     Highcharts.theme = {
//        // colors: ["#f45b5b", "#8085e9", "#8d4654", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
//        //    "#55BF3B", "#DF5353", "#7798BF", "#aaeeee", null],
//        chart: {
//           backgroundColor: null,
//           style: {
//              fontFamily: "Montserrat, Helvetica Neue"
//           }
//        },
//        tooltip: {
//           borderWidth: 0
//        },

//        plotOptions: {
//           series: {
//              shadow: true
//           },
//           map: {
//              shadow: true
//           }
//        },
//        // Highstock specific

//        // // General
//        // background2: '#E0E0E8'
//     };

//     // Apply the theme
//     Highcharts.setOptions(Highcharts.theme);
// });












// angular.module('formApp', ['ngAnimate', 'ui.router'])

// // configuring the routes
// // =============================================================================
// .config(function($stateProvider, $urlRouterProvider) {

//     $stateProvider

//         // route to show our basic form (/form)
//         .state('form', {
//             url: '/steps',
//             templateUrl: 'steps.html.erb',
//             controller: 'formController'
//         })

//         // nested states
//         // each of these sections will have their own view
//         // url will be nested (/form/profile)
//         .state('form.profile', {
//             url: '/industries/index',
//             templateUrl: 'index.html.erb'
//         })

//         // url will be /form/interests
//         .state('form.interests', {
//             url: '/industries/',
//             templateUrl: 'form-interests.html'
//         })

//         // url will be /form/payment
//         .state('form.payment', {
//             url: '/payment',
//             templateUrl: 'form-payment.html'
//         });

//     // catch all route
//     // send users to the form page
//     $urlRouterProvider.otherwise('../index');
// })

// // our controller for the form
// // =============================================================================
// .controller('formController', function($scope) {

//     // we will store all of our form data in this object
//     $scope.formData = {};

//     // function to process the form
//     $scope.processForm = function() {
//         alert('awesome!');
//     };

// });
