import Chart from 'chart.js'

var createChart = function (chartId, chartData) {
  const ctx = document.getElementById(chartId)
  const myChart = new Chart(ctx, {
    type: chartData.type,
    data: chartData.data,
    options: chartData.options,
  })
}

export default createChart