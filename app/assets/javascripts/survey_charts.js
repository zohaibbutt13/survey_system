function renderChart(data, labels, canvas_id, colorHex) {
      let ctx = document.getElementById(canvas_id).getContext('2d');
      let myChart = new Chart(ctx, {
        type: 'pie',
        data: {
          datasets: [{
            data: data,
            backgroundColor: colorHex
          }],
          labels: labels
        }
      });
}