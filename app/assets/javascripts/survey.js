$(document).ready(function() {
  $('body').on('click', '.js-addoption', function(event){
    event.preventDefault();
    var question_id_js = $(this).data("qid"); 
    var option_id_js = $(this).data("oid");
    var div_id_js = $(this).data("divid");
    option_id_js = option_id_js + 1;
    div_id_js = div_id_js + 1;
    $(this).data("oid", option_id_js);
    $(this).data("divid",div_id_js);
    $.ajax({
      type: 'GET',
      url: '/surveys/add_option',
      data: { question_id: question_id_js, option_id: option_id_js, option_div_id: div_id_js }
    });
  });

  $('body').on('click', '.js-addquestion', function(event){
    event.preventDefault();
    var count = $(this).data("count");
    count = count + 1 ;
    $(this).data("count", count)
    $.ajax({
      type: 'GET',
      url: '/surveys/add_question',
      data: { question_count: count }
    });
  });

  $('body').on('click', '.js-deleteoption', function(event){
    event.preventDefault();
    var option_id_js = $(this).data("oid");
    var question_id_js = $(this).data("qid");
    var div_id_js = $(this).data("divid");
    $.ajax({
      type: 'GET',
      url: '/surveys/delete_option',
      data: { question_id: question_id_js, option_id: option_id_js, option_div_id: div_id_js }
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
});
