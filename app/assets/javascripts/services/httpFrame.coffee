angular.module('snookerLeague').service 'httpFrame', ($http) ->

  @updateOne = (matchId, frame) ->
    $http
      method: 'PATCH'
      url: 'api/matches/'+matchId+'/frames/'+frame.id
      data: frame

  return