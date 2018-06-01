<template>
  <tbody>
    <tr v-for='subscription in subscriptions' :class='rowClass(subscription)'>
      <td>{{ subscription.oid }}</td>
      <td>{{ subscription.customer.name }}</td>
      <td>{{ subscription.plan.name }}</td>
      <td><span class="text-info">{{ numberToCurrency(subscription) }} {{ subscription.plan.interval }}</span></td>
      <td><button class="btn btn-sm btn-info" v-on:click='edit(subscription)'>Edit</button></td>
    </tr>
  </tbody>
</template>
<script>
import Events from '../../events'
import Utils from '../../utils'

export default {
  props: {
    initial_subscriptions: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      subscriptions: this.initial_subscriptions,
      notify: null
    }
  },
  methods: {
    edit (subscription) {
      Events.$emit('subscription:edit', subscription)
      this.notify = null
    },
    rowClass (subscription) {
      if (this.notify === null) return ''
      if (subscription.id === this.notify)
        return 'changed'
      else
        return ''
    },
    numberToCurrency (subscription) {
      return Utils.numberToCurrency(Number(subscription.plan.amount), subscription.plan.currency)
    }
  },
  created () {
    Events.$on('subscription:created', (subscription) => {
      this.subscriptions.unshift(subscription)
      this.notify = subscription.id
    })

    Events.$on('subscription:updated', (subscription) => {
      var index = this.subscriptions.findIndex((p) => p.id === subscription.id)
      this.$set(this.subscriptions, index, subscription)
      this.notify = subscription.id
    })
  }
}
</script>
<style lang="scss" scoped>
@import '../../styles/_variables.scss';

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
    background-color: $info;
  }

  100% {
    background-color: #FFFFFF;
  }
}
</style>