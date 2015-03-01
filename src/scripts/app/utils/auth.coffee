RSVP = require 'rsvp'
co   = require 'co'

class Auth
  token: null
  setToken: (token) ->
    @token = token
  getToken: ->
    return @token

module.exports = new Auth()