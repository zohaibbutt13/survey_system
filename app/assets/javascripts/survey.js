$(document).ready(function() {
  $('body').on('click', '.js-addquestion', function(event){
    event.preventDefault();
    var count = $(this).data("count");
    count = count + 1 
    $(this).data("count", count)
    $.ajax({
      type: 'GET',
      url: '/surveys/add_question',
      data: { question_count: count }
    });
  });
});