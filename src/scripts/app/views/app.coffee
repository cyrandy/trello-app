Backbone            = require 'backbone'
$                   = require 'jquery-untouched'
Backbone.$          = $

Metions             = require '../collections/notifications'
MessageListView     = require '../views/notificationsList'

class AppView extends Backbone.View
  el: $('body')
  initialize: ->
    @metions = new Metions()
    messageListView = new MessageListView {collection: @metions}

module.exports = AppView