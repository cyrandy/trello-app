Backbone        = require 'backbone'
_               = require 'underscore'

class SearchResultsView extends Backbone.View
  template: _.template '''
    <% _.each(boards, function(board) { %>
      <div class="board-container">
        <p><%= board[0][0].boardName %></p>
        <% _.each(board, function(list) { %>
          <div class="list">
            <p><%= list[0].listName %></p>
            <div class="list-cards">
            <% _.each(list, function(card) { %>
              <div class="card"><%= card.name %></div>
            <% }); %>
            </div>
          </div>
        <% }); %>
      </div>
    <% }); %>
  '''
  initialize: ->
    @.listenTo @collection, 'sync', @render

  getElement: ->
    $('.search-results')

  render: ->
    # console.log @collection.models.toJSON()
    # console.log _.map @collection.models, (model) ->
    #   return _.toArray model.attributes
    # boards = @collection.models[0]?.attributes
    # console.log @collection.models

    boards = _.map @collection.models, (model) ->
      return _.toArray model.attributes
    # console.log boards
    # # console.log @collection.models[0].attributes
    # # console.log boards
    # # console.log '---------'
    # _.each boards, (board) ->
    #   console.log 'Board: ' + board[0][0].boardName
    #   # console.log _.toArray board

    #   _.each board, (list) ->
    #     console.log 'List: ' + list[0].listName

    #     _.each list, (card) ->
    #       console.log 'card - ' + card.name
    @$el.html @template({boards})
    @


module.exports = SearchResultsView