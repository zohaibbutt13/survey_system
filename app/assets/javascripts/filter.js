$(document).ready(function() {
  $('#js-name-filter').click(function (event) {
    event.preventDefault();
    var name = $(':input[id="survey-name"]').val();
    $.ajax({
      type: 'GET',
      url: '/companies/filter',
      data: { filters: { name: name } }
    });
  });

  $('#js-expired-before-filter').click(function (event) {
    event.preventDefault();
    var expired_before = $(':input[id="expired-before"]').val();
    $.ajax({
      type: 'GET',
      url: '/companies/filter',
      data: { filters: { expired_before: expired_before } }
    });
  });

  $('#js-survey-type-filter').click(function (event) {
    event.preventDefault();
    var e = document.getElementById("survey-type-filter");
    var survey_type = e.options[e.selectedIndex].value;
    $.ajax({
      type: 'GET',
      url: '/companies/filter',
      data: { filters: { survey_type: survey_type } }
    });
  });
});