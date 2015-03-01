PouchDb = require 'pouchdb'
co      = require 'co'
_       = require 'underscore'
db      = new PouchDb('trello-app')

exports.getInstance = ->
  db

exports.updateLocalDb = (collection, response, opts) -> co ->
  currentDocs = yield db.allDocs()
  currentIds = _.map currentDocs.rows, (d) ->
    d.id

  # insert not exist docs only
  newDocs = _.chain collection.models
    .filter (m) ->
      not _.contains currentIds, m.get('id')
    .map (m) ->
      _.extend m.attributes, {_id: m.get('id')}
    .value()
  yield db.bulkDocs newDocs
  currentDocs = yield db.allDocs {include_docs: true}
  console.log currentDocs

# exports.