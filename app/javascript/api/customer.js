import axios from 'axios'

class Customer {
  constructor (customer) {
    this.customer = customer
  }
  
  create () {
    return axios.post(`/customers`, {
      customer: this.customer
    })
  }

  update () {
    return axios.patch(`/customers/${this.customer.id}`, {
      customer: this.customer
    })
  }

  save () {
    if (this.customer.id) {
      return this.update()
    } else {
      return this.create()
    }
  }
}

export default Customer