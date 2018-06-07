<template>
  <tbody>
    <tr v-for='plan in plans' :class='rowClass(plan)' v-on:click='show(plan)'>
      <td>{{ plan.oid }}</td>
      <td>{{ plan.name }}</td>
      <td>{{ amountToCurrency(plan) }} {{ plan.interval }}</td>
      <td>{{ totalToCurrency(plan) }} monthly</td>
      <td><button class="btn btn-sm btn-info btn-sm-td" v-on:click.prevent='edit(plan)'>Edit</button></td>
    </tr>
  </tbody>
</template>
<script>
import Events from '../../events'
import Utils from '../../utils'

export default {
  props: {
    initial_plans: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      plans: this.initial_plans,
      notify: null
    }
  },
  methods: {
    edit (plan) {
      Events.$emit('plan:edit', plan)
      this.notify = null
    },
    rowClass (plan) {
      if (this.notify === null) return 'pointer-on-hover'
      if (plan.id === this.notify)
        return 'pointer-on-hover updated'
      else
        return 'pointer-on-hover'
    },
    amountToCurrency (plan) {
      return Utils.numberToCurrency(Number(plan.amount), plan.currency)
    },
    totalToCurrency (plan) {
      return Utils.numberToCurrency(Number(plan.total_monthly), plan.currency)
    },
    show (plan) {
      window.location = `/plans/${plan.id}`
    }
  },
  created () {
    Events.$on('plan:created', (plan) => {
      this.plans.unshift(plan)
      this.notify = customer.id
    })

    Events.$on('plan:updated', (plan) => {
      var index = this.plans.findIndex((p) => p.id === plan.id)
      this.$set(this.plans, index, plan)
      this.notify = plan.id
    })
  }
}
</script>
<style lang="scss" scoped>
.pointer-on-hover:hover {
  cursor: pointer;
}
</style>
