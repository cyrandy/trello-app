Backbone        = require 'backbone'
_               = require 'underscore'

class SearchResultsView extends Backbone.View
  template: _.template '''
    <% _.each(boards, function(board) { %>
      <div class="board-container">
        <a class="normal-margin-btm" href="https://trello.com/b/<%= board[0][0].boardId %>" target='_blank'><%= board[0][0].boardName %></a>
        <% _.each(board, function(list) { %>
          <div class="list">
            <a class="normal-margin-btm list-name" href="https://trello.com/b/<%= board[0][0].boardId %>" target='_blank'><%= list[0].listName %></a>
            <div class="list-cards">
            <% _.each(list, function(card) { %>
              <a class="card" target="_blank" href="<%= card.shortUrl %>"><%= card.name %></a>
            <% }); %>
            </div>
          </div>
        <% }); %>
      </div>
    <% }); %>
  '''
  emptyTpl: _.template '''
    <p class='notfound'>No results.</p>
  '''
  loadingTpl: _.template '''
    <div class="spinner">
      <div class="rect1"></div>
      <div class="rect2"></div>
      <div class="rect3"></div>
      <div class="rect4"></div>
    </div>
  '''

  initialize: ->
    @.listenTo @collection, 'sync', @render
    @.listenTo @collection, 'error', @renderEmpty
    @.listenTo @collection, 'fetch', @loading

  getElement: ->
    $('.search-results')

  render: ->
    boards = _.map @collection.models, (model) ->
      return _.toArray model.attributes
    if boards.length
      @$el.html @template({boards})
    else
      @renderEmpty()
    @

  renderEmpty: ->
    @$el.html @emptyTpl()

  loading: ->
    @$el.html @loadingTpl()

module.exports = SearchResultsView
