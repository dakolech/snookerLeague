angular.module('snookerLeague').controller "statisticsController", [
  '$scope', 'httpStaticPages',
  ($scope, httpStaticPages) ->

    httpStaticPages.getStatistics().then (dataResponse) ->
      $scope.statistics = dataResponse.data

]

