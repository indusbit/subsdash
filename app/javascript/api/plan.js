import axios from 'axios'

class Plan {
  constructor(plan) {
    this.plan = plan
  }
  
  create() {
    return axios.post(`/plans`, {
      plan: this.plan
    })
  }
}

export default Plan