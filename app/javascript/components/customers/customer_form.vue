<template>
  <Card :header='header'>
    <form v-on:submit.prevent='submit'>
      <InputField label='Your ID' model='customer' field='oid' v-model='customer.oid'/>
      <InputField label='Name' model='customer' field='name' v-model='customer.name' />
      <InputField label='Email' model='customer' field='email' v-model='customer.email' type='email' />
      <div class='form-group'>
        <label>Notes</label>
        <textarea class='form-control' v-model='customer.notes'></textarea>
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
    customer_attributes: {
      type: Object,
      required: true
    }
  },
  data: function () {
    return {
      customer: this.customer_attributes,
      submitting: false
    }
  },
  methods: {
    submit () {
      var that = this
      that.submitting = true
      var customerApi = new API.Customer(that.customer)
      customerApi.save()
        .then(response => {
          var customer = that.customer
          this.resetcustomer()
        })
        .catch(error => {
          alert(error)
          console.log(error)
          that.submitting = false
        })
    },
    resetcustomer () {
      this.customer = {
        id: null,
        name: null,
        email: null,
        oid: null,
        notes: null,
      }
      this.submitting = false
    }
  },
  computed: {
    header () {
      if (this.customer.id) {
        return `Editing - ${this.customer.name}`
      } else {
        return 'Add a new customer'
      }
    }
  },
  components: {
    InputField,
    Card
  },
  created: function () {
    Cable.customers(this) // Subscribe to updating customers in real time

    Events.$on('customer:edit', (customer) => {
      this.customer = customer
    })
  }
}
</script>
<style scoped>
  
</style>
