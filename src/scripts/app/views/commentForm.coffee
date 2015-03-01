Backbone = require 'backbone'
_        = require 'underscore'
auth     = require '../utils/auth'

class commentFormView extends Backbone.View
  events:
    'submit': 'onSubmit'

  initialize: (options) ->
    @parent = options.parent
    @model.set
      token: auth.getToken()

  onSubmit: (e) ->
    e.preventDefault()
    text = @$el.find('input').val()
    @.model.save({text}, {emulateJSON : true, data : @.model.attributes, method: 'POST'})

module.exports = commentFormView