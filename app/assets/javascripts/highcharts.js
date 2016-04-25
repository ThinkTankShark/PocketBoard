$(document).ready(function(){
  addChart();

});

var addChart = function(){
  $("#example").on("click",function(){
    console.log(gon.array)
    $("#chart").html(gon.array)
    debugger;
  })
}
