<<<<<<< HEAD
=======
$(document).ready(function(){

    swipeRightListener();
    swipeLeftListener();
    yesButtonListener();
    noButtonListener();

});

var swipeRightListener = function() {
  $(".buddy").on("swiperight",function(){
      console.log("right")
      $(this).addClass('rotate-left').delay(700).fadeOut(1);
      $('.buddy').find('.status').remove();

      $(this).append('<div class="status like">Like!</div>');
      if ( $(this).is(':last-child') ) {
        $('.buddy:nth-child(1)').removeClass ('rotate-left rotate-right').fadeIn(300);
       } else {
          $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
       }
    });
}

var swipeLeftListener = function() {
  $(".buddy").on("swipeleft",function(){
    console.log("left")
    $(this).addClass('rotate-right').delay(700).fadeOut(1);
    $('.buddy').find('.status').remove();
    $(this).append('<div class="status dislike">Dislike!</div>');

    if ( $(this).is(':last-child') ) {
     $('.buddy:nth-child(1)').removeClass ('rotate-left rotate-right').fadeIn(300);
      // alert('Na-na!');
     } else {
        $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
    }
  });
}

var yesButtonListener = function() {
  $('.yes-button').on('click', function(event) {
    console.log("yes")

    event.preventDefault();

    var stock_id = $(this).parent().parent().children()[3].value;
    var user_id = $(this).parent().parent().children()[2].value;
    var authenticity = $(this).parent().parent().children()[1].value;
    var that = $(this)

    var request = $.ajax({
      url: "/stocks_users",
      type: "post",
      data: {stock_user: {stock_id: stock_id, user_id: user_id}},
      other: that
    })

    request.done(function(response){
      $(this.other).parent().parent().parent().addClass('rotate-left').delay(700).fadeOut(1);
    })

    request.fail(function(response){
      console.log("failed")
    });
  });
}

var noButtonListener = function() {
  $('.no-button').on('click', function(event) {
    console.log("no")
    event.preventDefault();
    $(this).parent().parent().parent().addClass('rotate-right').delay(700).fadeOut(1);
  });
}
>>>>>>> da73dd6af3e099a01a3a9ab51e817747deb35056
