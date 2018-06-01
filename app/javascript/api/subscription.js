import axios from 'axios'

class Subscription {
  constructor (subscription) {
    this.subscription = subscription
  }
  
  create () {
    return axios.post(`/subscriptions`, {
      subscription: this.subscription
    })
  }

  update () {
    return axios.patch(`/subscriptions/${this.subscription.id}`, {
      subscription: this.subscription
    })
  }

  save () {
    if (this.subscription.id) {
      return this.update()
    } else {
      return this.create()
    }
  }
}

export default Subscription