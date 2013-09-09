class EventNavigation extends Backbone.View
    el: '.event-nav'
    template: require "views/templates/sub-nav"

    initialize: ->

    render: ->
        @$el.html @template {
            links:
                [
                    { name: "Уредувач", target: "events/new" },
                    { name: "Листа на настани", target: "events/list" },
                ]
        }

    activate: (index) ->
        @$el.find("li").removeClass "active"
        @$el.find("li").eq(index).addClass "active"

module.exports = EventNavigation