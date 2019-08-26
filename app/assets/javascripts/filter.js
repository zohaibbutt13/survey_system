$(document).ready(function() {
  $('#js-name-filter').click(function (event) {
    event.preventDefault();
    var name = $('#survey_name').val();
    if(name) {
      $.ajax({
        type: 'GET',
        url: '/companies/filter',
        data: { filters: 'name', options: { value: name } }
      });
      $('#name_modal').modal('toggle');
      return true;
    } else {
      alert("Enter name first.");
      return false;
    }
  });

  $('#js-expired-before-filter').click(function (event) {
    event.preventDefault();
    var expired_before = $('#expired_before').val();
    if(expired_before) {
      $.ajax({
        type: 'GET',
        url: '/companies/filter',
        data: { filters: 'expired_before', options: { value: expired_before } }
      });
      $('#expired_before_modal').modal('toggle');
      return true;
    } else {
      alert("Select date first.");
      return false;
    }
  });

  $('#js-survey-type-filter').click(function (event) {
    event.preventDefault();
    var e = document.getElementById("survey_type_filter");
    var survey_type = e.options[e.selectedIndex].value;
    if(survey_type) {
      $.ajax({
        type: 'GET',
        url: '/companies/filter',
        data: { filters: 'survey_type', options: { value: survey_type } }
      });
      $('#survey_type_modal').modal('toggle');
      return true;
    } else {
      alert("Select type first.");
      return false;
    }
  });

  $('#js-created-on-filter').click(function (event) {
    event.preventDefault();
    var created_on = $('#created_on').val();
    if(created_on) {
      $.ajax({
        type: 'GET',
        url: '/companies/filter',
        data: { filters: 'created_on', options: { value: created_on } }
      });
      $('#created_on_modal').modal('toggle');
      return true;
    } else {
      alert("Select date first.");
      return false;
    }
  });

  $('#js-created-by-filter').click(function (event) {
    event.preventDefault();
    var created_by_id = $('#created_by option:selected').val();
    if(created_by_id) {
      $.ajax({
        type: 'GET',
        url: '/companies/filter',
        data: { filters: 'created_by', options: { value: created_by_id } }
      });
      $('#created_by_modal').modal('toggle');
      return true;
    } else {
      alert("Select employee first.");
      return false;
    }
  });
});