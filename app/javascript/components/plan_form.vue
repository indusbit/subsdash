<template>
  <div>
    <button v-on:click="show = true" class="btn btn-primary float-right" v-if="!show">Add a Plan</button>
    <Card v-if="show">
      <form v-on:submit.prevent="submit($event)">
        <InputField label="Your ID" model="plan" field="oid" v-model="plan.oid" />
        <InputField label="Name" model="plan" field="name" v-model="plan.name" />
        <InputField label="Amount" model="plan" field="amount" v-model="plan.amount" type="number" />
        <InputField label="Platform" model="plan" field="platform" v-model="plan.platform" />

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
    submit: function (event) {
      console.log(this.plan)
    }
  },
  components: {
    InputField,
    Card
  }
}
</script>
<style scoped>
  
</style>