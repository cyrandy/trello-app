Backbone          = require 'Backbone'
AppView           = require '../views/app'
MessagesListView  = require '../views/messagesList'
SearchResults     = require '../collections/searchResults'
SearchResultsView = require '../views/searchResults'


class AppRouter extends Backbone.Router
  routes:
    '': 'showMain'
    'search': 'searchCard'

  initialize: ->
    @appView = AppView

  showMain: ->
    @messagesListView = new MessagesListView {collection: @appView.metions}
    @appView.setChildView @messagesListView

  searchCard: ->
    @searchResults = new SearchResults()
    @searchResultsView = new SearchResultsView({collection: @searchResults})

    @appView.setChildView @searchResultsView

module.exports = AppRouter
