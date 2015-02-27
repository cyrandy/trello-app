Backbone        = require 'Backbone'
AppView         = require '../views/app'
MessagesListView = require '../views/messagesList'

class AppRouter extends Backbone.Router
  routes:
    '': 'showMain'
    'search': 'searchCard'

  initialize: ->
    @appView = AppView.getInstance()

  showMain: ->
    @messagesListView = new MessagesListView {collection: @appView.metions}
    @appView.setChildView @messagesListView

  searchCard: ->
    @appView.setChildView()

module.exports = AppRouter