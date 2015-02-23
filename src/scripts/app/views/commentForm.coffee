Backbone = require 'backbone'
_        = require 'underscore'


class commentFormView extends Backbone.View
  events: 
    'submit': 'onSubmit'

  initialize: (options) ->
    @parent = options.parent

  onSubmit: (e) ->
    e.preventDefault()
    text = @$el.find('input').val()
    @.model.save({text}, {emulateJSON : true, data : @.model.attributes, method: 'POST'})

module.exports = commentFormView