<template>
  <Card :header='header'>
    <form v-on:submit.prevent='submit'>
      <InputField label='Your ID' model='plan' field='oid' v-model='plan.oid'/>
      <InputField label='Name' model='plan' field='name' v-model='plan.name' />
      <InputField label='Amount' model='plan' field='amount' v-model='plan.amount' type='number' />
      <InputField label='Platform' model='plan' field='platform' v-model='plan.platform' />
      <div class='form-group'>
        <label for='plan-form-interval'>Interval</label>
        <select v-model='plan.interval' class='form-control' id='plan-form-interval'>
          <option disabled value=''>Please select one</option>
          <option value='monthly'>Monthly</option>
          <option value='yearly'>Yearly</option>
          <option value='weekly'>Weekly</option>
          <option value='daily'>Daily</option>
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
    plan_attributes: {
      type: Object,
      required: true
    }
  },
  data: function () {
    return {
      plan: this.plan_attributes,
      submitting: false
    }
  },
  methods: {
    submit () {
      var that = this
      that.submitting = true
      var planApi = new API.Plan(that.plan)
      planApi.save()
        .then(response => {
          var plan = that.plan
          this.resetPlan()
        })
        .catch(error => {
          alert(error)
          console.log(error)
          that.submitting = false
        })
    },
    resetPlan () {
      this.plan = {
        id: null,
        amount: null,
        interval: null,
        interval_count: 1,
        name: null,
        oid: null,
        platform: null,
        currency: 'USD'
      }
      this.submitting = false
    }
  },
  computed: {
    header () {
      if (this.plan.id) {
        return `Editing - ${this.plan.name}`
      } else {
        return 'Add a new Plan'
      }
    }
  },
  components: {
    InputField,
    Card
  },
  created: function () {
    this.plan.interval_count = 1
    this.plan.currency = 'USD'

    Cable.plans(this) // Subscribe to updating plans in real time

    Events.$on('plan:edit', (plan) => {
      this.plan = plan
    })
  }
}
</script>
<style scoped>
  
</style>