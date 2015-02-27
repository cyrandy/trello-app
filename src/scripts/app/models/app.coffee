Backbone = require 'backbone'

class AppViewModel extends Backbone.Model
  defaults: 
    childView: null

module.exports = AppViewModel