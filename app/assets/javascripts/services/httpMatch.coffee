angular.module('snookerLeague').service 'httpMatch', ($http) ->

  @getEdit = (matchId) ->
    $http
      method: 'GET'
      url: 'api/matches/'+matchId+'/edit.json'

  @updatePlayer = (matchId, which, playerId) ->
    $http
      method: 'PATCH'
      url: 'api/matches/'+matchId+'/update_player/'+which+'/'+playerId

  @updateOne = (match) ->
    $http
      method: 'PATCH'
      url: 'api/matches/'+match.id
      data: match

  return