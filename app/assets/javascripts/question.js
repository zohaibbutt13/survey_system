$(document).ready(function() {
  $('body').on('click', '.js-addoption', function(event){
    event.preventDefault();
    var qid = $(this).data("qid"); 
    var oid = $(this).data("oid");
    oid = oid + 1;
    $(this).data("oid", oid)
    $.ajax({
      type: 'GET',
      url: '/surveys/add_option',
      data: { question_id: qid, option_id: oid }
    });
  });
});
