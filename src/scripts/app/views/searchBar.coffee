Backbone            = require('backbone')
$                   = require 'jquery-untouched'
Backbone.$          = $
_                   = require('underscore')

AppView             = require '../views/app'

class SearchBarView extends Backbone.View
  el: $('#search-bar')

  events:
    'click .home': 'goHome'
    'click .search-bar': 'initSearch'
    'keyup .search-bar': 'onInput'

  goHome: ->
    app.navigate '', {trigger: true, replace: true}

  initSearch: ->
    app.navigate 'search', {trigger: true, replace: true}
    @searchResults = app.searchResults

  onInput: ->
    @searchResults.fetch {
      data: {
        query: $('.search-input').val()
      }
    }


module.exports = SearchBarView