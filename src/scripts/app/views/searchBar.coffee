Backbone            = require('backbone')
$                   = require 'jquery-untouched'
Backbone.$          = $
_                   = require('underscore')

class SearchBarView extends Backbone.View
  el: $('#search-bar')

  events:
    'click .home': 'goHome'
    'click .search-bar': 'initSearch'

  goHome: ->
    app.navigate '', {trigger: true, replace: true}

  initSearch: ->
    app.navigate 'search', {trigger: true, replace: true}

module.exports = SearchBarView