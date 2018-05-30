<template>
  <div class="form-group">
    <label :for="identifier">{{label}}</label>
    <input v-model="calculatedValue" :type="calculatedType" :name="name" :value="value" :id="identifier" class="form-control">
  </div>
</template>
<script>
export default {
  props: ['model', 'field', 'value', 'label', 'type'],
  data: function () {
    return {
      name: this.model + "[" + this.field + "]",
      identifier: this.model + "-form-" + this.field,
      calculatedType: this.type || 'text',
      calculatedValue: this.value
    }
  },
  watch: {
    value (n, o) {
      this.calculatedValue = n
    },
    calculatedValue: function (value, old) {
      this.$emit('input', value)
    }
  }
}
</script>
<style scoped>
  
</style>