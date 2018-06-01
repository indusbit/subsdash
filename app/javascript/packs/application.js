/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.
import Vue from 'vue/dist/vue.esm'
import Notifications from 'vue-notification'
import Rails from 'rails-ujs'
import axios from 'axios'
import 'bootstrap/dist/js/bootstrap';
import '../styles/common.scss'

import page from '../page.vue'

import PlanForm from '../components/plans/plan_form'
import PlanList from '../components/plans/plan_list'
import CustomerForm from '../components/customers/customer_form'
import CustomerList from '../components/customers/customer_list'


Rails.start()

Vue.use(Notifications)

Vue.component('page', page)
Vue.component('plan_form', PlanForm)
Vue.component('plan_list', PlanList)
Vue.component('customer_form', CustomerForm)
Vue.component('customer_list', CustomerList)


document.addEventListener('DOMContentLoaded', () => {
  // This code will setup headers of X-CSRF-Token that it grabs from rails generated token in meta tag.
  axios.defaults.headers.common['X-CSRF-Token'] = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')

  const app = new Vue({
    el: '#app'
  })
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks';
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
