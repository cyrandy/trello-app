Backbone = require 'backbone'
auth    = require('../utils/auth')
key     = require('../utils/key')()

class Comment extends Backbone.Model
  defaults: {
    key: key
    cardId: ''
    text: ''
  }

  url: ->
    cardId = @.get('cardId')
    return "https://api.trello.com/1/cards/#{cardId}/actions/comments"

module.exports = Comment