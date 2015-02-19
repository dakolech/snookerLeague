angular.module('snookerLeague').service 'roundService', () ->

  @checkPlayers = (rounds, players) ->
    for round in rounds
      for player in players
        count = 0
        for match in round.matches
          if match && match.player_1 && match.player_2
            if match.player_1.name == player.name
              count++
            if match.player_2.name == player.name
              count++
        if count > 1
          changePlayerClass(round.matches, 'repeatedPlayer', player.name)
        else
          changePlayerClass(round.matches, 'correct', player.name)
    rounds

  changePlayerClass = (matches, className, playerName) ->
    for match in matches
      if match && match.player_1 && match.player_2
        if match.player_1.name == playerName
          match.player_1.class = className
        if match.player_2.name == playerName
          match.player_2.class = className

  @checkMatches = (rounds) ->
    matches = collectMatches(rounds)

    for playerName in matches
      count = countSameMatches(playerName, rounds)

      if count > 1
        rounds = changeClass(playerName, rounds, 'repeatedMatch')
      else
        rounds = changeClass(playerName, rounds, 'correct')
    rounds


  collectMatches = (rounds) ->
    matches = []
    for round in rounds
      for match in round.matches
        if match && match.player_1 && match.player_2
          matches.push(match.player_1.name+" "+match.player_2.name)
    matches

  countSameMatches = (playerName, rounds) ->
    count = 0
    for round in rounds
      for match in round.matches
        if match && match.player_1 && match.player_2
          if playerName == match.player_1.name+" "+match.player_2.name ||
             playerName == match.player_2.name+" "+match.player_1.name
            count++
    count

  changeClass = (playerName, rounds, className) ->
    for round in rounds
      for match in round.matches
        if match && match.player_1 && match.player_2
          if playerName == match.player_1.name+" "+match.player_2.name ||
             playerName == match.player_2.name+" "+match.player_1.name
            match.class = className
    rounds

  return