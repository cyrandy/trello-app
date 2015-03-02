Backbone        = require('backbone')
$               = require 'jquery-untouched'
Backbone.$      = $
_               = require 'underscore'

NotificationView = require('../views/notification')

class MessagesList extends Backbone.View
  initialize: ->
    _.bindAll @, 'hide'
    $(document).bind 'click', @hide
    @.listenTo @collection, 'sync', @render
    # @.listenTo @collection, 'add', @render
    @render()

  hide: (e) ->
    e.stopPropagation()
    className = $(e.target).attr('class')
    @collection.resetSelected() unless $(@el).find(".#{className}").length

  getElement: ->
    $('.list-items-container')

  render: ->
    notificationsView = @collection.models.map (noti) ->
      new NotificationView(model: noti).render().el

    @$el.html notificationsView
    @

module.exports = MessagesList
