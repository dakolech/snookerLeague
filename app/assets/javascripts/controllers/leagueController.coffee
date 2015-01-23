angular.module('snookerLeague').controller "leagueController", [
  '$scope', '$http', '$attrs', 'flash', 'ngDialog'
  ($scope, $http, $attrs, flash, ngDialog) ->

    $scope.leagueId = $attrs.model
    $scope.loading = true
    $scope.showAllText = false

    $http.get('leagues/'+$scope.leagueId+'/show_angular.json')
    .success (data) ->
      $scope.league = data.league
      $scope.loading = false
      console.log $scope.league.playersBreaks[0].breaks[0]
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.searchMatches = (id) ->
      for round in $scope.league.rounds
        for match in round.matches
          if match.player_1.id != id && match.player_2.id != id
            match.class = 'hidden'
            $scope.showAllText = true

    $scope.showAll = () ->
      for round in $scope.league.rounds
        for match in round.matches
          match.class = 'unhidden'
      $scope.showAllText = false


]