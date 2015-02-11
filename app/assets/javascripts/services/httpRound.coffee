angular.module('snookerLeague').service 'httpRound', ($http) ->

  @getEditAll = (leagueId) ->
    $http
      method: 'GET'
      url: 'api/leagues/'+leagueId+'/rounds/edit_all.json'

  @generateRounds = (leagueId, how) ->
    $http
      method: 'GET'
      url: 'api/leagues/'+leagueId+'/rounds/generate_' + how + '.json'

  @updateOne = (leagueId, round) ->
    $http
      method: 'PATCH'
      url: 'api/leagues/'+leagueId+'/rounds/'+round.id
      data: round


  return
