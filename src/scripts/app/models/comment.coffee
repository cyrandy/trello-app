Backbone = require 'backbone'
token    = require('../utils/token')()

class Comment extends Backbone.Model
  defaults: {
    key: '154407f68384bde233183669d08042d5'
    token: token
    cardId: ''
    text: ''
  }

  url: ->
    cardId = @.get('cardId')
    return "https://api.trello.com/1/cards/#{cardId}/actions/comments"

module.exports = Comment