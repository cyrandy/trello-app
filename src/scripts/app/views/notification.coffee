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
      <ul class='message-panel'>
        <li class="icon-read panel-action"></li>
      </ul>
    </div>
    <form class='reply-form'>
      <input type="text" name="text" placeholder="Reply" class="reply-content">
    </form>
  '''
  events:
    'click .message': 'showReplyForm'
    'mouseover .message': 'showPanel'
    'mouseleave .message': 'hidePanel'
  
  initialize: ->
    @listenTo @model, 'change', @render
    
    commentModel = new Comment({cardId: @.model.get('cardId')})
    @commentFormView = new CommentFormView({parent: @, model: commentModel})
    
    @panelView = new MsgPanelView({parent: @}) 

  showReplyForm: ->
    @.model.setSelected()

  render: ->
    $(@el).removeClass 'active'
    $(@el).addClass @model.get('clickStatus')
    @.$el.html @template(@model.toJSON())
    @commentFormView.setElement(@.$el.find('.reply-form'))
    @panelView.setElement(@.$el.find('.message-panel'))
    @

  read: ->
    @model.putDoc({unread: false, readStatus: 'read'})

module.exports = NotificationView
