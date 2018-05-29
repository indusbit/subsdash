<template>
  <div class="container">
    <h1>{{ heading }}</h1>
    <hr />
    <slot></slot>
  </div>
</template>
<script>
export default {
  props: {
    heading: {
      type: String,
      required: true
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