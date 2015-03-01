Backbone = require 'Backbone'
_        = require 'underscore'
db       = require('../utils/db').getInstance()

class Notification extends Backbone.Model
  defaults: {
    clickStatus: ''
  }

  setSelected: ->
    @.collection.setSelected(@)

  putDoc: (opts) ->
    @.set opts
    db.get @.get('id'), (err, res) =>
      console.log res
      db.put @.attributes, @.get('id'), res._rev, (err, res) ->
        console.log err if err
        db.get res.id, (err, res) ->
          console.log res
module.exports = Notification