<template>
  <tbody>
    <tr v-for='customer in customers' :class='rowClass(customer)'>
      <td>{{ customer.oid }}</td>
      <td>{{ customer.name }}</td>
      <td>{{ customer.email }}</td>
      <td><button class="btn btn-sm btn-info" v-on:click='edit(customer)'>Edit</button></td>
    </tr>
  </tbody>
</template>
<script>
import Events from '../../events'

export default {
  props: {
    initial_customers: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      customers: this.initial_customers,
      notify: null
    }
  },
  methods: {
    edit (customer) {
      Events.$emit('customer:edit', customer)
      this.notify = null
    },
    rowClass (customer) {
      if (this.notify === null) return ''
      if (customer.id === this.notify)
        return 'changed'
      else
        return ''
    }
  },
  created () {
    Events.$on('customer:created', (customer) => {
      this.customers.unshift(customer)
      this.notify = customer.id
    })

    Events.$on('customer:updated', (customer) => {
      var index = this.customers.findIndex((c) => c.id === customer.id)
      this.$set(this.customers, index, customer)
      this.notify = customer.id
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
