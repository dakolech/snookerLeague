angular.module('snookerLeague').controller "statisticsController", [
  '$scope', '$http',
  ($scope, $http) ->

    $http.get('statistics_angular.json')
    .success (data) ->
      $scope.statistics = data
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

]

