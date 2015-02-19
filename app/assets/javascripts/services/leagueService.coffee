angular.module('snookerLeague').service 'leagueService', () ->

  @hideMatches = (rounds, id) ->
    for round in rounds
      for match in round.matches
        if match.player_1.id != id && match.player_2.id != id
          match.class = 'hidden'
    rounds

  @unhideMatches = (rounds) ->
    for round in rounds
      for match in round.matches
        match.class = 'unhidden'
    rounds

  @deleteLeague = (leagues, indexLeague) ->
    leagues.splice(indexLeague, 1)
    leagues

  @findLeagueIndex = (leagues, leagueId) ->
    for league, index in leagues
      if league.id == leagueId
        return index
    -1

  @findPlayerIndex = (players, playerId) ->
    indexPlayer = -1
    for player, index in players
      if player.id == playerId
        return index
    -1

  return