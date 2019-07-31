$(document).ready(function() {
  $('body').on('click', '.js-addoption', function(event){
    event.preventDefault();
    var qid = $(this).data("qid"); 
    var oid = $(this).data("oid");
    var divid = $(this).data("divid");
    oid = oid + 1;
    divid = divid + 1;
    $(this).data("oid", oid);
    $(this).data("divid",divid);
    $.ajax({
      type: 'GET',
      url: '/surveys/add_option',
      data: { question_id: qid, option_id: oid, option_div_id: divid }
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
    var oid = $(this).data("oid");
    var qid = $(this).data("qid");
    var divid = $(this).data("divid");
    $.ajax({
      type: 'GET',
      url: '/surveys/delete_option',
      data: { question_id: qid, option_id: oid, option_div_id: divid }
    });
  });

  $('body').on('click', '.js-deletequestion', function(event){
    event.preventDefault();
    var qid = $(this).data("qid");
      $.ajax({
      type: 'GET',
      url: '/surveys/delete_question',
      data: { question_id: qid }
    });
  });
});