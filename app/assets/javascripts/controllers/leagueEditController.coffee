angular.module('snookerLeague').controller "leagueEditController", [
  '$scope', '$http', '$attrs', 'flash'
  ($scope, $http, $attrs, flash) ->

    $scope.leagueId = $attrs.model

    $http.get('leagues/'+$scope.leagueId+'/edit_angular.json')
    .success (data) ->
      $scope.league_players = data.league_players
      $scope.players = data.players
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.addPlayer = (playerId) ->
      $http.patch('/leagues/'+$scope.leagueId+'/add_player/'+playerId,{})
      .success (data) ->
        $scope.league_players = data
        indexPlayer = -1
        for player, index in $scope.players
          if player.id == playerId
            indexPlayer = index

        flash('Player ' + $scope.players[indexPlayer].firstname + ' ' + $scope.players[indexPlayer].lastname + ' was successfully added to league')
        $scope.players.splice(indexPlayer, 1)
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.removePlayer = (playerId) ->
      $http.patch('/leagues/'+$scope.leagueId+'/remove_player/'+playerId,{})
      .success (data) ->
        indexPlayer = -1
        for player, index in $scope.league_players
          if player.id == playerId
            indexPlayer = index
        $scope.players.push($scope.league_players[indexPlayer])
        flash('warning', 'Player ' + $scope.league_players[indexPlayer].firstname + ' ' + $scope.league_players[indexPlayer].lastname + ' was successfully removed from league')
        $scope.league_players = data
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

]