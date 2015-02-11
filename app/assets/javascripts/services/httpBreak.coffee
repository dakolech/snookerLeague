angular.module('snookerLeague').service 'httpBreak', ($http) ->

  @createOne = (matchId, frameId, playerId) ->
    $http
      method: 'POST'
      url: 'api/matches/'+matchId+'/frames/'+frameId+'/breaks'
      data: {break: {player_id: playerId, frame_id: frameId}}

  @updateOne = (matchId, frameId, breakId, points) ->
    $http
      method: 'PATCH'
      url: 'api/matches/'+matchId+'/frames/'+frameId+'/breaks/'+breakId
      data:  {break: {points: points}}

  @deleteOne = (matchId, frameId, breakId) ->
    $http
      method: 'DELETE'
      url: 'api/matches/'+matchId+'/frames/'+frameId+'/breaks/'+breakId

  return