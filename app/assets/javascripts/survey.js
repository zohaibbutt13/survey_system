$(document).ready(function() {
  $('body').on('click', '.js-addquestion', function(event){
    event.preventDefault();
    var count = $(this).data("count");
    count = count + 1; 
    $(this).data("count", count)
    $.ajax({
      type: 'GET',
      url: '/surveys/add_question',
      data: { question_count: count }
    });
  });

  $('body').on('click', '.js-deletequestion', function(event){
    event.preventDefault();
    var question_id_js = $(this).data("qid");
      $.ajax({
      type: 'GET',
      url: '/surveys/delete_question',
      data: { question_id: question_id_js }
    });
  });

  $('body').on('click', '.js-responses', function(event){
    event.preventDefault();
    var sid = $(this).data("survey_id");
      $.ajax({
      type: 'GET',
      url: '/surveys/'+sid+'/user_responses',
      data: { survey_id: sid }
    });
  });

  $('#survey_survey_type').on('change', function() {
    if ( this.value == 'Private')
    {
      $("#group").show();
    }
    else
    {
      $("#group").hide();
    }
  });
});
