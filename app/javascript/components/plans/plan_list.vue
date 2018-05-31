<template>
  <tbody>
    <tr v-for='plan in plans' :class='rowClass(plan)'>
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
      if (this.notify === null) return ''
      if (plan.id === this.notify)
        return 'changed'
      else
        return ''
    }
  },
  created () {
    Events.$on('plan:created', (plan) => {
      this.plans.push(plan)
    })

    Events.$on('plan:updated', (plan) => {
      var index = this.plans.findIndex((p) => p.id === plan.id)
      this.notify = plan.id
      this.$set(this.plans, index, plan)
    })
  }
}
</script>
<style scoped>
.btn-sm {
  font-size: 0.75rem;
  padding-top: 0.2rem;
  padding-bottom: 0.2rem;
}

tr.changed {
  animation: pulse 500ms 3;
}

@keyframes pulse {
  0% {
    background-color: #FFFFFF;
  }

  50% {
    background-color: #B060D1;
  }

  100% {
    background-color: #FFFFFF;
  }
}
</style>