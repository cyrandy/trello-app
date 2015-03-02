Backbone = require 'Backbone'
_        = require 'underscore'
auth    = require('../utils/auth')
key     = require('../utils/key')()
db      = require('../utils/db').getInstance()
co      = require 'co'

class Notifications extends Backbone.Collection
  model: require '../models/notification'
  url: ->
    token = auth.getToken()
    "https://api.trello.com/1/members/my/notifications?key=#{key}&token=#{token}&filter=mentionedOnCard"
  selected: null

  setSelected: (m) ->
    if @selected
      @selected.set {clickStatus: null}
    @selected = m
    @selected.set {clickStatus: 'active'}

  resetSelected: ->
    @selected.set {clickStatus: ''} if @selected

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

  fetchLocalDb: () -> co ->
    currentDocs = yield db.allDocs {include_docs: true}
    docs = _.chain currentDocs.rows
      .map ({doc}) ->
        doc.cdate = new Date(doc.cdate)
        doc
      .sortBy (doc) ->
        return -doc.cdate.getTime()
      .map (doc) ->
        doc.cdate = doc.cdate.toString()
        doc
      .value()

module.exports = Notifications
