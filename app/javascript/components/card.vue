<template>
  <div class="card" v-on:click="click">
    <div v-if="header" class="card-header">
      {{ header }}
    </div>
    <div class="card-body">
      <slot></slot>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    header: {
      type: String,
      required: false
    }
  },
  data: function () {
    return {

    }
  },
  methods: {
    click: function () {

    }
  }
}
</script>
<style scoped>

</style>