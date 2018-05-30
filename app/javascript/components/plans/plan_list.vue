<template>
  <tbody>
    <tr v-for='plan in plans'>
      <td>{{ plan.oid }}</td>
      <td>{{ plan.name }}</td>
      <td>{{ plan.amount }} / {{ plan.interval }}</td>
      <td><button class="btn btn-sm btn-info" v-on:click='edit(plan)'>Edit</button></td>
    </tr>
  </tbody>
</template>
<script>
import Events from '../../events'

export default {
  props: {
    initial_plans: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      plans: this.initial_plans
    }
  },
  methods: {
    edit (plan) {
      Events.$emit('plan:edit', plan)
    }
  },
  created () {
    Events.$on('plan:created', (plan) => {
      this.plans.push(plan)
    })
  }
}
</script>
<style scoped>
  
</style>