angular.module('snookerLeague').controller "headerController", [
  '$scope',
  ($scope) ->
    ###
    $http.get('statistics.json')
    .success (data) ->
      $scope.statistics = data
      return
    .error (data) ->
      console.log('Error: ' + data)
      return
    ###
]

