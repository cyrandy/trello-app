'use strict'

co                  = require 'co'
$                   = require 'jquery-untouched'
Backbone            = require 'Backbone'
_                   = require 'underscore'
RSVP                = require 'rsvp'


MainView            = require './app/views/app'
AppRouter           = require './app/routers/app'
DB                  = require('./app/utils/db')
db                  = DB.getInstance()
auth                = require './app/utils/auth'

derferred = RSVP.defer()

Trello.authorize {
  scope: { write: true, read: true }
  success: ->
    auth.setToken(Trello.token())
    derferred.resolve()
}

$ ->
  window.app = new AppRouter()
  Backbone.history.start {
    root: '/'
    pushState: false
  }

derferred.promise.then ->
  mainView            = MainView.getInstance()
  metions             = mainView.metions

  co ->
    docs = yield metions.fetchLocalDb()
    metions.set docs
    yield metions.fetch({merge: false, add: true, success: DB.updateLocalDb})
  .catch (err) ->
    console.log err
