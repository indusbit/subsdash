<template>
  <div>
    <button v-on:click='showForm = true' class='btn btn-primary float-right' v-if='!showForm'>Add a Plan</button>
    <Card v-if='showForm'>
      <form v-on:submit.prevent='submit'>
        <InputField label='Your ID' model='plan' field='oid' v-model='plan.oid' />
        <InputField label='Name' model='plan' field='name' v-model='plan.name' />
        <InputField label='Amount' model='plan' field='amount' v-model='plan.amount' type='number' />
        <InputField label='Platform' model='plan' field='platform' v-model='plan.platform' />
        <div class='form-group'>
          <label>Interval</label>
          <select v-model='plan.interval' class='form-control'>
            <option disabled value=''>Please select one</option>
            <option value='monthly'>Monthly</option>
            <option value='yearly'>Yearly</option>
            <option value='weekly'>Weekly</option>
            <option value='daily'>Daily</option>
          </select>
        </div>
        <input v-if="!submitting" type='submit' value='Add' name='commit' class='btn btn-primary'>
        <input v-else type='submit' value='Adding...' name='commit' class='btn btn-primary' disabled>
        <button v-on:click.prevent='showForm = false' class='btn btn-danger'>
          Close Form
        </button>
      </form>
    </Card>
  </div>
</template>
<script>
import InputField from '../input_field.vue'
import Card from '../card.vue'
import API from '../../api/index.js'

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
      showForm: false,
      submitting: false
    }
  },
  methods: {
    submit () {
      var that = this
      that.submitting = true
      var planApi = new API.Plan(that.plan)
      planApi.create()
        .then(response => {
          // window.location = window.location
          console.log(response)
          var plan = that.plan
          this.$notify({
            group: 'foo',
            title: 'Plan added!',
            type: 'success',
            text: 'Plan with oid: ' + plan.oid + ' and name: ' + plan.name + ' added.'
          });
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
  components: {
    InputField,
    Card
  },
  created: function () {
    this.plan.interval_count = 1
    this.plan.currency = 'USD'
  }
}
</script>
<style scoped>
  
</style>