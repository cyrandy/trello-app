Backbone            = require 'backbone'
$                   = require 'jquery-untouched'
Backbone.$          = $
_                   = require 'underscore'

class MessagePanelView extends Backbone.View
  template: _.template '''
    <li class="icon-read panel-action"></li>
  '''
  tagName: 'ul'
  className: 'message-panel'

  events:
    'click .icon-read': 'read'

  initialize: (options) ->
    @parent = options.parent

  read: (e) ->
    e.stopImmediatePropagation()
    @parent.read()

  render: ->
    @.$el.html @template()
    @

module.exports = MessagePanelView