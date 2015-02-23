'use strict'

co                  = require 'co'
$                   = require 'jquery-untouched'
_                   = require 'underscore'

Metions             = require './app/collections/notifications'
data                = require './data.json'
metions             = new Metions()

MessageListView     = require './app/views/notificationsList'
messageListView     = new MessageListView {collection: metions}

db                  = require './app/utils/db'

fetchLocalDb = () -> co ->
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
  metions.set docs
.catch (err) ->
  console.log err

# TODO: render should wait until fetch from server done
updateLocalDb = (collection, response, opts) -> co ->
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
.catch (err) ->
  console.log err

co ->
  yield fetchLocalDb()
  yield metions.fetch({merge: false, add: true, success: updateLocalDb})
.catch (err) ->
  console.log err