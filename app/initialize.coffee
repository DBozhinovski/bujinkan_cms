# Load App Helpers
require 'lib/helpers'

# Initialize Router
require 'routers/main'

$ ->
    # Initialize Backbone History
    location.hash = ""
    Backbone.history.start pushState: no

    $(".main-nav li").on "click", ->
        $(".main-nav li").removeClass "active"
        $(@).addClass "active"