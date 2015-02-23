Backbone = require 'Backbone'
_        = require 'underscore'
token    = require('../utils/token')()
co       = require 'co'
db       = require '../utils/db'

class Notifications extends Backbone.Collection
  model: require '../models/notification'
  url: "https://api.trello.com/1/members/my/notifications?key=154407f68384bde233183669d08042d5&token=#{token}&filter=mentionedOnCard"
  selected: null

  setSelected: (m) ->
    if @.selected
      @.selected.set {clickStatus: null}
    @.selected = m
    @.selected.set {clickStatus: 'active'}

  parse: (res) ->
    r = _.map res, (data) ->
      {
          id: data.id
          cdate: data.date
          unread: data.unread
          readStatus: if data.unread then 'unread' else 'read'
          text: data.data.text
          cardId: data.data.card.id
          cardLink: data.data.card.shortLink
          boardId: data.data.board.id
          boardLink: data.data.board.shortLink
          creatorId: data.memberCreator.id
          creatorAvatarHash: data.memberCreator.avatarHash
          creatorInitials: data.memberCreator.initials
      }

module.exports = Notifications