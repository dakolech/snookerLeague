angular.module('snookerLeague').controller "leagueController", [
  '$scope', '$routeParams', 'flash', 'ngDialog', 'httpLeague'
  ($scope, $routeParams, flash, ngDialog, httpLeague) ->

    $scope.loading = true
    $scope.showAllText = false

    httpLeague.getOne($routeParams.id).then (dataResponse) ->
      $scope.league = dataResponse.data.league
      $scope.loading = false

    $scope.searchMatches = (id) ->
      $scope.showAll()
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