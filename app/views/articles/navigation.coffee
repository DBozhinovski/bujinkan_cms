class ArticleNavigationView extends Backbone.View
    el: ".article-nav"
    template: require "views/templates/sub-nav"

    initialize: ->
        
    render: ->
        @$el.html @template {
            links:
                [
                    { name: "Уредувач", target: "articles/new" },
                    { name: "Листа на написи", target: "articles/list" },
                ]
        }

    events:
        "click li": "set_active"

    set_active: (event) ->
        @$el.find("li").removeClass "active"
        $(event.currentTarget).addClass "active"

    activate: (index) ->
        @$el.find("li").removeClass "active"
        @$el.find("li").eq(index).addClass "active"


module.exports = ArticleNavigationView