angular.module('snookerLeague').controller "roundsEditController", [
  '$scope', '$http', '$routeParams'
  ($scope, $http, $routeParams) ->

    $scope.id = $routeParams.id

    $http.get('api/leagues/'+$scope.id+'/rounds/edit_all.json')
    .success (data) ->
      $scope.league = data.league
      checkPlayers()
      checkMatches()
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.updatePlayer = (round, match, player) ->
      if player == 1
        playerId = $scope.league.rounds[round].matches[match].player_1.id
      else
        playerId = $scope.league.rounds[round].matches[match].player_2.id
      roundId = $scope.league.rounds[round].number
      matchId = $scope.league.rounds[round].matches[match].id
      $http.patch('api/leagues/'+$scope.id+'/rounds/'+round+'/matches/'+matchId+'/update_player/'+player+'/'+playerId)
      .success (data) ->
        if player == 1
          $scope.league.rounds[round].matches[match].player_1.id = data.player.id
          $scope.league.rounds[round].matches[match].player_1.name = data.player.name
        else
          $scope.league.rounds[round].matches[match].player_2.id = data.player.id
          $scope.league.rounds[round].matches[match].player_2.name = data.player.name
        checkPlayers()
        checkMatches()
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.generateFilled = ->
      $http.get('api/leagues/'+$scope.id+'/rounds/generate_filled.json')
      .success (data) ->
        $scope.league = data.league
        checkPlayers()
        checkMatches()
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.generateEmpty = ->
      $http.get('api/leagues/'+$scope.id+'/rounds/generate_empty.json')
      .success (data) ->
        $scope.league = data.league
        checkPlayers()
        checkMatches()
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.updateStartDate = (id, date) ->
      $http.patch('api/leagues/'+$scope.id+'/rounds/'+id, {round: {start_date: date, id: id}})
       .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.updateEndDate = (id, date) ->
      $http.patch('api/leagues/'+$scope.id+'/rounds/'+id, {round: {end_date: date, id: id}})
      .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.updateMatchDate = (id, date, roundId) ->
      $http.patch('api/leagues/'+$scope.id+'/rounds/'+roundId+'/matches/'+id, {match: {date: date, id: id}})
      .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

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
