<template>
  <Card :header='header'>
    <form v-on:submit.prevent='submit'>
      <InputField label='Your ID' model='subscription' field='oid' v-model='subscription.oid'/>
      <div class='form-group'>
        <label for='subscription-form-customer'>Customer</label>
        <select v-model='subscription.customer_id' class="form-control" id='subscription-form-customer'>
          <option disabled value=''>Please select one</option>
          <option v-for='customer in customers' :value='customer.id'>{{customer.name}}</option>
        </select>
      </div>
      <div class='form-group'>
        <label for='subscription-form-plan'>Plan</label>
        <select v-model='subscription.plan_id' class="form-control" id='subscription-form-plan'>
          <option disabled value=''>Please select one</option>
          <option v-for='plan in plans' :value='plan.id'>{{plan.name}}</option>
        </select>
      </div>
      <input v-if="!submitting" type='submit' value='Save' name='commit' class='btn btn-primary'>
      <input v-else type='submit' value='Saving...' name='commit' class='btn btn-primary' disabled>
    </form>
  </Card>
</template>
<script>
import InputField from '../input_field.vue'
import Card from '../card.vue'
import API from '../../api/index.js'
import Events from '../../events'
import Cable from '../../cable'

export default {
  props: {
    subscription_attributes: {
      type: Object,
      required: true
    },
    customers: Array,
    plans: Array
  },
  data: function () {
    return {
      subscription: this.subscription_attributes,
      submitting: false
    }
  },
  methods: {
    submit () {
      var that = this
      that.submitting = true

      if (!that.subscription.started_at)
        that.subscription.started_at = (new Date()).toISOString()

      var subscriptionApi = new API.Subscription(that.subscription)
      subscriptionApi.save()
        .then(response => {
          var subscription = that.subscription
          this.resetSubscription()
        })
        .catch(error => {
          alert(error)
          console.log(error)
          that.submitting = false
        })
    },
    resetSubscription () {
      this.subscription = {
        id: null,
        oid: null,
        quantity: 1,
        active: true,
        started_at: null,
        customer_id: null,
        plan_id: null,
      }
      this.submitting = false
    }
  },
  computed: {
    header () {
      if (this.subscription.id) {
        return `Editing - ${this.subscription.oid}`
      } else {
        return 'Add a new subscription'
      }
    }
  },
  components: {
    InputField,
    Card
  },
  created: function () {
    this.subscription.quantity = 1
    this.subscription.active = true

    Cable.subscriptions(this) // Subscribe to updating subscriptions in real time

    Events.$on('subscription:edit', (subscription) => {
      this.subscription = subscription
    })
  }
}
</script>
<style scoped>
  
</style>
