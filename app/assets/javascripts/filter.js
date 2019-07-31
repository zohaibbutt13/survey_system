$(document).ready(function() {
  $('#js-filter').click(function (event) {
    event.preventDefault();
    var name = $(':input[id="survey-name"]').val();
    var expired_after = $(':input[id="expired-after"]').val();
    var expired_before = $(':input[id="expired-before"]').val();
    var created_after = $(':input[id="created-after"]').val();
    var created_before = $(':input[id="created-before"]').val();
    $.ajax({
      type: 'GET',
      url: '/companies/filter',
      data: { filters: { name: name, expired_after: expired_after, expired_before: expired_before, created_after: created_after, created_before: created_before } }
    });
  });
});
