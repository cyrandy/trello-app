Backbone            = require 'backbone'
$                   = require 'jquery-untouched'
Backbone.$          = $
_                   = require 'underscore'

AppViewModel        = require '../models/app'

Metions             = require '../collections/notifications'
MessageListView     = require '../views/messagesList'

SearchBarView       = require '../views/searchBar'

class AppView extends Backbone.View
  el: $('.main')
  template: _.template '''
    <div class="list-items-container"></div>
    <div class="search-results"></div>
  '''

  initialize: ->
    @searchBarView = new SearchBarView()

    # FIXME: sync metions should be done in metions initialize
    @metions = new Metions()

    @.listenTo @model, 'change:childView', @render

  setChildView: (view) ->
    @model.get('childView').remove() if @model.get('childView')
    @model.set {
      childView: view
    }

  render: ->
    @$el.html @template()
    childView = @model.get('childView')
    childView.setElement(childView.getElement()).render() if childView
    @

module.exports = new AppView({model: new AppViewModel()})
