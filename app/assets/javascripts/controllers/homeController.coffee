angular.module('snookerLeague').controller "homeController", [
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

