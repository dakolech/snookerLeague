angular.module('snookerLeague').controller "leagueController", [
  '$scope', '$http', '$attrs', 'flash', 'ngDialog'
  ($scope, $http, $attrs, flash, ngDialog) ->

    $scope.leagueId = $attrs.model

    $http.get('leagues/'+$scope.leagueId+'/show_angular.json')
    .success (data) ->
      $scope.league = data.league
      return
    .error (data) ->
      console.log('Error: ' + data)
      return


]