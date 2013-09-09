ArticleCollection = require "collections/articles"
Categories = require "collections/categories"
Translation = require "models/translation"

class ArticleListView extends Backbone.View
    el: ".article-list"
    template: require "views/templates/articles/list"

    initialize: ->
        @collection = new ArticleCollection()
        @collection.on "sync", @render, @

        @categories = new Categories
        @categories.on "sync", @set_categories, @

        @_filter = {}
        @rendered = @collection

    render: ->
        if Object.getOwnPropertyNames(@_filter).length is 0
            @rendered = @collection

        @$el.html @template {
            articles: @rendered.toJSON()
        }

        for key, value of @_filter
            $("#"+key).val(value)

        @fetch_categories()

    set_categories: ->
        category_data = @categories.toJSON()
        options = "<option>-</option>"

        for category in category_data
            if @_filter.category is category.name
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
        "change select": "filter"
        "change #page": "fetch_categories"

    filter: (event) ->
        target = $(event.currentTarget)
        if target.val() is "-"
            delete @_filter[target.attr('name')]
        else
            @_filter[target.attr('name')] = target.val()

        @rendered = new ArticleCollection(@collection.where(@_filter))
        @render()

    fetch_categories: () ->
        target = @$el.find("#page").val()
        if target isnt "-"
            @categories.set_filter("page", target).reset().fetch {
                success: => @categories.trigger "fetched"
            }


module.exports = ArticleListView