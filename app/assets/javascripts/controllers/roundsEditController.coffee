angular.module('snookerLeague').controller "roundsEditController", [
  '$scope', '$http'
  ($scope, $http) ->

    $scope.id

    $scope.init = (league_id) ->
      $scope.id = league_id
      console.log $scope.id
      $http.get('leagues/'+league_id+'/rounds/edit_all_angular.json')
        .success (data) ->
          #console.log data
          $scope.league = data.league
          return
        .error (data) ->
          console.log('Error: ' + data)
          return

]
