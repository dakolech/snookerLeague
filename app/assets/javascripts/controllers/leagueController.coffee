angular.module('snookerLeague').controller "leagueController", [
  '$scope', '$http', '$attrs', 'flash', 'ngDialog'
  ($scope, $http, $attrs, flash, ngDialog) ->

    $scope.leagueId = $attrs.model
    $scope.loading = true

    $http.get('leagues/'+$scope.leagueId+'/show_angular.json')
    .success (data) ->
      $scope.league = data.league
      $scope.loading = false
      return
    .error (data) ->
      console.log('Error: ' + data)
      return


]