ArticleNavigation = require "views/articles/navigation"
ArticleEditor = require "views/articles/editor"
ArticleList = require "views/articles/list"
ArticleModel = require "models/article"

class ArticleRouter extends Backbone.Router
    routes:
        "": "create_article"
        "articles/new": "create_article"
        "articles/edit/:id": "edit_article"
        "articles/delete/:id": "delete_article"
        "articles/list": "list_articles"

    initialize: ->
        $('.app').append "<div class='article-list'>"
        $('.app').append "<div class='article-editor'>"
        $('.sub-nav').append "<div class='article-nav'>"
        $(".app > *").hide()
        @views = {}

        @views.editor = new ArticleEditor
        @views.list = new ArticleList
        @views.navigation = new ArticleNavigation
        @views.navigation.render()

        @navigate "articles/new", { trigger: true }
        @views.navigation.activate 0

    create_article: ->
        $('.sub-nav > *').hide()
        $(".article-nav").show()

        $(".app > *").hide()
        @views.editor.set_id()
        @views.editor.$el.show()
        @views.navigation.activate 0

    edit_article: (id) ->
        $(".app > *").hide()
        @views.editor.set_id id
        @views.editor.$el.show()
        @views.navigation.activate 0

    list_articles: ->
        $(".app > *").hide()
        @views.list.collection.fetch { reset: true }
        @views.list._filter = {}
        @views.list.$el.show()
        @views.navigation.activate 1

    delete_article: (id) ->
        article = new ArticleModel { id: id }
        article.on "destroy", -> alert "Избришано" # Bootstrap modal
        article.destroy()
        @navigate "articles/list", { trigger: true }

module.exports = new ArticleRouter