Backbone            = require('backbone')
$                   = require 'jquery-untouched'
Backbone.$          = $
_                   = require('underscore')

class SearchBarView extends Backbone.View
  el: $('#search-bar')

  events:
    'click': 'initSearch'

  initSearch: ->
    app.navigate 'search', {trigger: true, replace: true}

module.exports = SearchBarView