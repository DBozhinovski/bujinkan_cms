ArticleModel = require "models/article"
Categories = require "collections/categories"
Translation = require "models/translation"

class ArticleEditorView extends Backbone.View
    el: ".article-editor"
    template: require "views/templates/articles/editor"

    initialize: (id = false) ->
        @changed = {}

        @model = new ArticleModel
        @model.on "sync", @render, @

        @categories = new Categories
        @categories.on "sync", @set_categories, @

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
            @title = "Нов напис"
        else
            @title = @model.get "title"

        @$el.html @template
            article: @model.toJSON()
            categories: @categories.toJSON()
            head: @title

        for key, value of @model.toJSON()
            if @model.get key
                @$el.find("#"+key).val(value)

        if @model.id
            @fetch_categories()

        @$el.find('.summernote').summernote { height: '600px' }
        @$el.find('.summernote').code @model.get('content')

    set_categories: ->
        category_data = @categories.toJSON()
        options = "<option>-</option>"

        for category in category_data
            if @model.get("category") is category.name
                selected = "selected"
            else
                selected = ""
            options += "
                <option value='#{category.name}' #{selected}>
                    " + Translation.get(category.name) + "
                </option>
            "

        @$el.find("#category").html(options)

    events:
        "click #save": "submit"
        "keyup input": "update_model"
        "change select": "update_model"
        "change #page": "fetch_categories"

    submit: ->
        @changed['content'] = $(".summernote").code()[0]
        @model.save @changed, { success: -> alert "Зачувано" }

    update_model: (event) ->
        target = $(event.currentTarget)
        @changed[target.attr('name')] = target.val()

    fetch_categories: () ->
        target = @$el.find("#page").val()
        if target isnt "-"
            @categories.set_filter("page", target).reset().fetch {
                success: => @categories.trigger "fetched"
            }

module.exports = ArticleEditorView