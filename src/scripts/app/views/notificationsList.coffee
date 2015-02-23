Backbone        = require('backbone')
$               = require 'jquery-untouched'
Backbone.$      = $
_               = require 'underscore'

NotificationView = require('../views/notification')

class NotificationsList extends Backbone.View
  initialize: ->
    @.listenTo @collection, 'sync', @render
    # @.listenTo @collection, 'add', @render
    @.setElement $('.list-items-container')

  render: ->
    notificationsView = @collection.models.map (noti) ->
      new NotificationView(model: noti).render().el

    @$el.html notificationsView
    @

module.exports = NotificationsList
