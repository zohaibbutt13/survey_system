$(document).ready(function() {
  $('body').on('click', '.js-survey_count', function(event){
    event.preventDefault();
    var uid = $(this).data("user_id");
    $.ajax({
      type: 'GET',
      url: '/members/'+uid+'/calculate_surveys',
      data: { user_id: uid }
    });
  })
});