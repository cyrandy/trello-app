Backbone        = require('backbone')
$               = require 'jquery-untouched'
Backbone.$      = $
_               = require 'underscore'

NotificationView = require('../views/notification')

class MessagesList extends Backbone.View
  initialize: ->
    @.listenTo @collection, 'sync', @render
    # @.listenTo @collection, 'add', @render
    @render()

  getElement: ->
    $('.list-items-container')

  render: ->
    notificationsView = @collection.models.map (noti) ->
      new NotificationView(model: noti).render().el

    @$el.html notificationsView
    @

module.exports = MessagesList
