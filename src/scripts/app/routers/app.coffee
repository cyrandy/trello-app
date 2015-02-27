Backbone = require 'Backbone'

class AppRouter extends Backbone.Router
  routes: 
    '': 'showMain'
    'search': 'searchCard'

  showMain: ->
    console.log 'show main'

  searchCard: ->
    console.log 'search'

module.exports = AppRouter