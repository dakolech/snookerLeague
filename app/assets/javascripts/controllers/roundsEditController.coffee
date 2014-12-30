angular.module('snookerLeague').controller "roundsEditController", [
  '$scope', '$http', '$attrs'
  ($scope, $http, $attrs) ->

    $scope.id = $attrs.model

    $http.get('leagues/'+$scope.id+'/rounds/edit_all_angular.json')
    .success (data) ->
      $scope.league = data.league
      $scope.selLeague = data.league
      return

    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.updatePlayer = (round, match, player) ->
      if player == 1
        playerId = $scope.selLeague.rounds[round].matches[match].player_1.id
      else
        playerId = $scope.selLeague.rounds[round].matches[match].player_2.id
      roundId = $scope.league.rounds[round].number
      matchId = $scope.league.rounds[round].matches[match].id
      console.log "Round: " + $scope.league.rounds[round].number + " Match: " + (match+1) + " Player: " +  playerId
      $http.patch('/leagues/'+$scope.id+'/rounds/'+round+'/matches/'+matchId+'/update_players/'+player+'/'+playerId)
      .success (data) ->
        console.log data
        if player == 1
          $scope.league.rounds[round].matches[match].player_1.id = data.id
          $scope.league.rounds[round].matches[match].player_1.name = data.firstname
        else
          $scope.league.rounds[round].matches[match].player_2.id = data.id
          $scope.league.rounds[round].matches[match].player_2.name = data.firstname
        return
      .error (data) ->
        console.log('Error: ' + data)
        return


    console.log $scope.id

]
