const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

environment.loaders.append('vue', vue)

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

module.exports = environment
