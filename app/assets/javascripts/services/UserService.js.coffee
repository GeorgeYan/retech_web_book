angular.module('retech_web_book').factory 'User', ($resource, $http) ->
  class User
    constructor: (errorHandler) ->
      @service = $resource('./user/:id.json',
                          {id: '@id'},
                          {query: {method:'GET', isArray:false, url:'./user/index.json'}})

    all: ->
      @service.query((-> null), @errorHandler)
