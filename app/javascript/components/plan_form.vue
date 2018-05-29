<template>
  <div>
    <button v-on:click="show = true" class="btn btn-primary float-right" v-if="!show">Add a Plan</button>
    <Card v-if="show">
      <form v-on:submit.prevent="submit">
        <InputField label="Your ID" model="plan" field="oid" v-model="plan.oid" />
        <InputField label="Name" model="plan" field="name" v-model="plan.name" />
        <InputField label="Amount" model="plan" field="amount" v-model="plan.amount" type="number" />
        <InputField label="Platform" model="plan" field="platform" v-model="plan.platform" />
        <div class="form-group">
          <label>Interval</label>
          <select v-model="plan.interval" class="form-control">
            <option disabled value="">Please select one</option>
            <option value="monthly">Monthly</option>
            <option value="yearly">Yearly</option>
            <option value="weekly">Weekly</option>
            <option value="daily">Daily</option>
          </select>
        </div>
        <input type="submit" value="Add" name="commit" class="btn btn-primary">
        <button v-on:click="show = false" class="btn btn-danger">
          Close Form
        </button>
      </form>
    </Card>
  </div>
</template>
<script>
import InputField from './input_field.vue'
import Card from './card.vue'
export default {
  props: {
    plan: {
      type: Object,
      required: true
    }
  },
  data: function () {
    return {
      show: false
    }
  },
  methods: {
    submit: function () {
      // Submit the form
    }
  },
  components: {
    InputField,
    Card
  },
  created: function () {
    this.plan.interval_count = 1
    this.plan.currency = "USD"
  }
}
</script>
<style scoped>
  
</style>