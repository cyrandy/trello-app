Backbone            = require('backbone')
$                   = require 'jquery-untouched'
Backbone.$          = $
_                   = require('underscore')
MsgPanelView        = require('../views/msgPanel')
CommentFormView     = require('../views/commentForm')
Comment             = require('../models/comment')

class NotificationView extends Backbone.View
  tagName: 'div'
  className: 'list-item'
  template: _.template '''
    <div class='message <%= readStatus %>'>
      <div class="member">
        <div class="member-initial"><%= creatorInitials %></div>
      </div>
      <div class="content"><%= text %></div>
    </div>
  '''
  events:
    'click': 'showReplyForm'
    'mouseover': 'showPanel'
    'mouseleave': 'hidePanel'
  
  initialize: ->
    @listenTo @model, 'change', @render

  render: ->
    console.log 'render'
    $(@el).addClass @model.get('clickStatus')
    @.$el.html @template(@model.toJSON())
    @

  showReplyForm: ->
    # @model.setSelected()

    unless @commentFormView
      commentModel = new Comment({cardId: @.model.get('cardId')})
      @commentFormView = new CommentFormView({parent: @, model: commentModel})
      @.$el.append @commentFormView.render().el

  read: ->
    @model.putDoc({unread: false, readStatus: 'read'})

  showPanel: ->
    unless @panelView
      @panelView = new MsgPanelView({parent: @}) 
      @.$el.find('.message').append @panelView.render().el

  hidePanel: ->
    @panelView.remove()
    delete @panelView
  
module.exports = NotificationView
