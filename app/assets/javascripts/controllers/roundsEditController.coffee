angular.module('snookerLeague').controller "roundsEditController", [
  '$scope', '$routeParams', 'httpRound', 'httpMatch', 'roundService'
  ($scope, $routeParams, httpRound, httpMatch, roundService) ->

    httpRound.getEditAll($routeParams.id).then (dataResponse) ->
      $scope.league = dataResponse.data.league
      checkCorrectness()

    $scope.updatePlayer = (round, match, player) ->
      if player == 1
        playerId = $scope.league.rounds[round].matches[match].player_1.id
      else
        playerId = $scope.league.rounds[round].matches[match].player_2.id
      matchId = $scope.league.rounds[round].matches[match].id
      httpMatch.updatePlayer(matchId, player, playerId).then (dataResponse) ->
        if player == 1
          $scope.league.rounds[round].matches[match].player_1 = dataResponse.data
        else
          $scope.league.rounds[round].matches[match].player_2 = dataResponse.data
        checkCorrectness()

    $scope.generateRounds = (how) ->
      httpRound.generateRounds($routeParams.id, how).then (dataResponse) ->
        $scope.league = dataResponse.data.league
        checkCorrectness()

    $scope.updateRound = (index, round) ->
      httpRound.updateOne($routeParams.id, round).then (dataResponse) ->
        $scope.league.rounds[index].start_date = dataResponse.data.start_date
        $scope.league.rounds[index].end_date = dataResponse.data.end_date

    checkCorrectness = ->
      $scope.league.rounds = roundService.checkPlayers($scope.league.rounds, $scope.league.players)
      $scope.league.rounds = roundService.checkMatches($scope.league.rounds)

 ]