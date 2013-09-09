class MainRouter extends Backbone.Router
    initialize: ->
        require "routers/article"
        require "routers/event"
        

main = new MainRouter()
module.exports = main
