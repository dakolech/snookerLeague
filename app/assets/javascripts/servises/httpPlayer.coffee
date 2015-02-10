angular.module('snookerLeague').service 'httpPlayer', ($http) ->

  @getAll =  ->
    $http
      method: 'GET'
      url: 'api/players/index.json'

  @getAllWithQuery = (query) ->
    $http
      method: 'GET'
      url: 'api/players/index.json?search_query=' + query

  @getOne = (id) ->
    $http
      method: 'GET'
      url: 'api/players/' + id + '.json'

  @createOne = (player) ->
    $http
      method: 'POST'
      url: 'api/players'
      data: player

  @updateOne = (player) ->
    $http
      method: 'PATCH'
      url: 'api/players/'+player.id
      data: player

  @deleteOne = (playerId) ->
    $http
      method: 'DELETE'
      url: 'api/players/'+ playerId

  return
