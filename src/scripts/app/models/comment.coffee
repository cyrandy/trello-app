Backbone = require 'backbone'
auth    = require('../utils/auth')

class Comment extends Backbone.Model
  defaults: {
    key: '154407f68384bde233183669d08042d5'
    cardId: ''
    text: ''
  }

  url: ->
    cardId = @.get('cardId')
    return "https://api.trello.com/1/cards/#{cardId}/actions/comments"

module.exports = Comment