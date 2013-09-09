class Categories extends Backbone.Collection
    url: "category"
    model = require "models/category"

    set_filters: (filters) ->
        @url = "category?"
        for key, filter of filters
            @url += "#{key}=#{filter}&"

        @

    set_filter: (key, filter) ->
        @url = "category?#{key}=#{filter}"
        @

module.exports = Categories