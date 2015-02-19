angular.module('snookerLeague').controller "leagueController", [
  '$scope', '$routeParams', 'flash', 'ngDialog', 'httpLeague', 'leagueService'
  ($scope, $routeParams, flash, ngDialog, httpLeague, leagueService) ->

    $scope.loading = true
    $scope.showAllText = false

    httpLeague.getOne($routeParams.id).then (dataResponse) ->
      $scope.league = dataResponse.data.league
      $scope.loading = false

    $scope.searchMatches = (id) ->
      $scope.showAll()
      $scope.league.rounds = leagueService.hideMatches($scope.league.rounds, id)
      $scope.showAllText = true

    $scope.showAll = () ->
      $scope.league.rounds = leagueService.unhideMatches($scope.league.rounds)
      $scope.showAllText = false


]