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

  update() {
    return axios.patch(`/plans/${this.plan.id}`, {
      plan: this.plan
    })
  }

  save() {
    if (this.plan.id) {
      return this.update()
    } else {
      return this.create()
    }
  }
}

export default Plan