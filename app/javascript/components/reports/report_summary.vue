<template>
  <Card :header='header'>
    <canvas :id='id'></canvas>
  </Card>
</template>
<script>
import Card from '../card.vue'
import ChartJS from './chart'
import Utils from '../../utils'

export default {
  props: ['chart', 'chart_name', 'chart_id', 'currency', 'summary'],
  data () {
    return {
      graph: {
        labels: this.chart.date,
        datasets: [{
          label: this.chart_name,
          data: this.chart.data,
          borderWidth: 2,
          borderColor: '#000000',
          backgroundColor: '#5a60da' // $primary from variables
        }]
      }
    }
  },
  components: {
    Card
  },
  computed: {
    id () {
      return this.chart_id
    },
    header () {
      var amount = Number(this.chart.data[this.chart.data.length - 1])
      
      if (this.summary == 'sum')
        amount = this.chart.data.reduce((sum, e) => sum + e)

      if (this.currency)
        amount = Utils.numberToCurrency(amount)

      return `${this.chart_name}: ${amount}`
    }
  },
  mounted () {
    var that = this
    var ticks = {
      beginAtZero: true
    }

    // Adding the ticks callback this way so yAxes doesn't look weird.
    if (that.currency) {
      ticks.callback = function (value, index, values) {
        return that.currency ? Utils.numberToCurrency(Number(value)) : value
      }
    }

    ChartJS(this.id, {
      type: 'line',
      data: this.graph,
      options: {
        responsive: true,
        animation: {
          duration: 0
        },
        scales: {
          xAxes: [{
            display: true
          }],
          yAxes: [{
            ticks: ticks,
            display: true
          }],
        },
        tooltips: {
          enabled: true
        },
        legend: {
          display: false
        },
        elements: {
          point: {
            radius: 1
          }
        }
      }
    })
  }
}  
</script>
<style lang="scss" unscoped>

</style>
