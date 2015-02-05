angular.module('snookerLeague').controller "homeController", [
  '$scope', '$http',
  ($scope, $http) ->
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

