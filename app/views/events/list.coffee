EventCollection = require "collections/events"

class EventListView extends Backbone.View
    el: ".event-list"
    template: require "views/templates/events/list"

    initialize: ->
        @collection = new EventCollection()
        @collection.on "sync", @render, @

    render: ->
        @$el.html @template { events: @collection.toJSON() }

module.exports = EventListView