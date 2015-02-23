Backbone = require 'backbone'
_        = require 'underscore'


class commentFormView extends Backbone.View
  tagName: 'form'
  className: 'reply-form'
  template: _.template '''
    <input type="text" name="text" placeholder="Reply" class="reply-content">
  '''

  events: 
    'submit': 'onSubmit'

  initialize: (options) ->
    @parent = options.parent

  render: ->
    @.$el.html @template()
    @

  onSubmit: (e) ->
    e.preventDefault()
    text = @$el.find('input').val()
    @.model.save({text}, {emulateJSON : true, data : @.model.attributes, method: 'POST'})

module.exports = commentFormView