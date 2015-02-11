angular.module('snookerLeague').service 'httpLeague', ($http) ->

  @getAll = (query) ->
    $http
      method: 'GET'
      url: 'api/leagues/index.json?search_query='+query

  @getOne = (id) ->
    $http
      method: 'GET'
      url: 'api/leagues/' + id + '.json'

  @getEdit = (id, query) ->
    $http
      method: 'GET'
      url: 'api/leagues/'+id+'/edit.json?search_query='+query

  @createOne = (league) ->
    $http
      method: 'POST'
      url: 'api/leagues'
      data: league

  @updateOne = (league) ->
    $http
      method: 'PATCH'
      url: 'api/leagues/'+league.id
      data: league

  @addPlayer = (leagueId, playerId) ->
    $http
      method: 'PATCH'
      url: 'api/leagues/'+leagueId+'/add_player/'+playerId

  @removePlayer = (leagueId, playerId) ->
    $http
      method: 'PATCH'
      url: 'api/leagues/'+leagueId+'/remove_player/'+playerId

  @deleteOne = (leagueId) ->
    $http
      method: 'DELETE'
      url: 'api/leagues/'+ leagueId

  return
