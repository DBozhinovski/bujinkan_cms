EventModel = require "models/event"

class EventEditorView extends Backbone.View
    el: ".event-editor"
    template: require "views/templates/events/editor"

    initialize: (id = false) ->
        @changed = {}

        @model = new EventModel
        @model.on "sync", @render, @

    set_id: (id) ->
        @changed = {}

        if id
            @model.set "id", id
            @model.fetch()
        else
            @model.clear()
            @render()

    render: ->
        unless @model.id
            @title = "Нов настан"
        else
            @title = @model.get "title"

        @$el.html @template
            event: @model.toJSON()
            head: @title

        for key, value of @model.toJSON()
            if @model.get key
                @$el.find("#"+key).val(value)

        # console.log @model.toJSON()

    events:
        "keyup input[type=text]": "update_model"
        "change input[type=file]": "serialize_image"
        "change select": "update_model"
        "click #save": "submit"

    update_model: (event) ->
        target = $(event.currentTarget)
        @changed[target.attr('name')] = target.val()

    serialize_image: (event) ->
        file = event.target.files[0]

        reader = new FileReader
        @$el.find(".name").text file.name

        reader.onload = (e) =>
            @$el.find(".preview").html "<img src='#{e.target.result}'>"
            @changed['thumbnail'] = e.target.result

        reader.readAsDataURL(file)

    submit: ->
        @model.save @changed, { success: -> alert "Зачувано" }

module.exports = EventEditorView