$(document).ready(function() {
  $('.survey-chart').find('canvas').each(function(){
    var canvas_id = $(this).attr('id');
    var chart_data = $('#' + canvas_id).data('chart-data');
    var chart_labels = $('#' + canvas_id).data('chart-labels');
    var chart_colors = $('#' + canvas_id).data('chart-colors');
    var chart_type = $('#' + canvas_id).data('chart-type');
    if(chart_type == 'bar')
      var chart_label = $('#' + canvas_id).data('chart-label');
    else
      var chart_label = '';

    let ctx = document.getElementById(canvas_id).getContext('2d');
    let myChart = new Chart(ctx, {
      type: chart_type,
      data: {
        datasets: [{
          data: chart_data,
          backgroundColor: chart_colors,
          label: chart_label
        }],
        labels: chart_labels
      }
    });
    canvas_id, chart_data, chart_labels, chart_colors ="";
  });
});