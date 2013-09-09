EventNavigation = require "views/events/navigation"
EventEditor = require "views/events/editor"
EventList = require "views/events/list"
EventModel = require "models/event"

class EventRouter extends Backbone.Router
    routes:
        "events/new": "create_event"
        "events/edit/:id": "edit_event"
        "events/delete/:id": "delete_event"
        "events/list": "list_events"

    initialize: ->
        $('.app').append "<div class='event-list'>"
        $('.app').append "<div class='event-editor'>"
        $('.sub-nav').append "<div class='event-nav'>"
        $(".app > *").hide()
        @views = {}

        @views.editor = new EventEditor
        @views.navigation = new EventNavigation
        @views.list = new EventList
        @views.navigation.render()

        @navigate "events/new", { trigger :true }
        @views.navigation.activate 0

    create_event: ->
        $('.sub-nav > *').hide()
        $(".event-nav").show()

        $(".app > *").hide()
        @views.editor.set_id()
        @views.editor.$el.show()
        @views.navigation.activate 0

    edit_event: (id) ->
        $(".app > *").hide()
        @views.editor.set_id id
        @views.editor.$el.show()
        @views.navigation.activate 0

    list_events: ->
        $(".app > *").hide()
        @views.list.collection.fetch { reset: true }
        @views.list.$el.show()
        @views.navigation.activate 1

    delete_event: (id) ->
        event = new EventModel { id: id }
        event.on "destroy", -> alert "Избришано" # Bootstrap modal
        event.destroy()
        @navigate "events/list", { trigger: true }


module.exports = new EventRouter