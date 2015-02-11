angular.module('snookerLeague').controller "roundsEditController", [
  '$scope', '$routeParams', 'httpRound', 'httpMatch'
  ($scope, $routeParams, httpRound, httpMatch) ->

    httpRound.getEditAll($routeParams.id).then (dataResponse) ->
      $scope.league = dataResponse.data.league
      checkPlayers()
      checkMatches()

    $scope.updatePlayer = (round, match, player) ->
      if player == 1
        playerId = $scope.league.rounds[round].matches[match].player_1.id
      else
        playerId = $scope.league.rounds[round].matches[match].player_2.id
      roundId = $scope.league.rounds[round].number
      matchId = $scope.league.rounds[round].matches[match].id
      httpMatch.updatePlayer(matchId, player, playerId).then (dataResponse) ->
        if player == 1
          $scope.league.rounds[round].matches[match].player_1 = dataResponse.data
        else
          $scope.league.rounds[round].matches[match].player_2 = dataResponse.data
        checkPlayers()
        checkMatches()

    $scope.generateRounds = (how) ->
      httpRound.generateRounds($routeParams.id, how).then (dataResponse) ->
        $scope.league = dataResponse.data.league
        checkPlayers()
        checkMatches()

    $scope.updateRound = (index, round) ->
      httpRound.updateOne($routeParams.id, round).then (dataResponse) ->
        $scope.league.rounds[index].start_date = dataResponse.data.start_date
        $scope.league.rounds[index].end_date = dataResponse.data.end_date

    checkPlayers = ->
      for round in $scope.league.rounds
        for player in $scope.league.players
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

    changePlayerClass = (matches, className, playerName) ->
      for match in matches
        if match && match.player_1 && match.player_2
          if match.player_1.name == playerName
            match.player_1.class = className
          if match.player_2.name == playerName
            match.player_2.class = className

    checkMatches = ->
      matches = []
      for round in $scope.league.rounds
        for match in round.matches
          if match && match.player_1 && match.player_2
            matches.push(match.player_1.name+" "+match.player_2.name)
      for matchArr in matches
        count = 0
        for round in $scope.league.rounds
          for match in round.matches
            if match && match.player_1 && match.player_2
              string = match.player_1.name+" "+match.player_2.name
              if matchArr == match.player_1.name+" "+match.player_2.name
                count++
        if count > 1
          for round in $scope.league.rounds
            for match in round.matches
              if match && match.player_1 && match.player_2
                string = match.player_1.name+" "+match.player_2.name
                if matchArr == match.player_1.name+" "+match.player_2.name
                  match.class = 'repeatedMatch'
        else
          for round in $scope.league.rounds
            for match in round.matches
              if match && match.player_1 && match.player_2
                string = match.player_1.name+" "+match.player_2.name
                if matchArr == match.player_1.name+" "+match.player_2.name
                  match.class = 'correct'
]
