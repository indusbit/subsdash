import ActionCable from 'actioncable'
import Events from './events'

var cable = ActionCable.createConsumer()

var channels = {
  plans (vm) {
    cable.subscriptions.create({ channel: 'PlansChannel' }, {
      received (data) {
        var plan = data.plan
        if (data.action === 'create') {
          Events.$emit('plan:created', plan)
          vm.$notify({
            group: 'foo',
            title: 'Plan added!',
            type: 'success',
            text: `Plan with oid: ${plan.oid} and name: ${plan.name} added.`
          })
        } else if (data.action === 'update') {
          Events.$emit('plan:updated', plan)
          vm.$notify({
            group: 'foo',
            title: 'Plan updated!',
            type: 'success',
            text: `Plan with oid: ${plan.oid} has been updated.`
          })
        }
      }
    })
  }
}

export default channels
