Backbone            = require 'backbone'
$                   = require 'jquery-untouched'
Backbone.$          = $

Metions             = require '../collections/notifications'
MessageListView     = require '../views/notificationsList'

SearchBarView       = require '../views/searchBar'

class AppView extends Backbone.View
  el: $('body')
  initialize: ->
    @metions = new Metions()
    messageListView = new MessageListView {collection: @metions}
    searchBarView = new SearchBarView()


module.exports = AppView