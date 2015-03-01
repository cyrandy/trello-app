Backbone = require 'Backbone'
_        = require 'underscore'
auth    = require('../utils/auth')

class SearchResults extends Backbone.Collection
  model: require '../models/searchResult'
  url: ->
    token = auth.getToken()
    "https://api.trello.com/1/search?key=154407f68384bde233183669d08042d5&token=#{token}&card_board=true&card_list=true"

  parse: (res) ->
    r = _.map res.cards, (data) ->
      data.boardName = data.board.name
      data.boardId = data.board.id
      data.listName = data.list.name
      data.listId = data.list.id
      _.pick data, 'id', 'name', 'boardId', 'boardName', 'listId', 'listName', 'shortUrl'

    groupByMulti = (obj, values, context) ->
      return obj unless values.length
      byFirst = _.groupBy(obj, values[0], context)
      rest = values.slice(1)
      for prop of byFirst
        byFirst[prop] = groupByMulti(byFirst[prop], rest, context)
      byFirst

    r1 = groupByMulti r, ['boardId', 'listId']

    _.toArray r1

module.exports = SearchResults