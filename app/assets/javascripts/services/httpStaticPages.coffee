angular.module('snookerLeague').service 'httpStaticPages', ($http) ->

  @getStatistics =  ->
    $http
      method: 'GET'
      url: 'api/statistics.json'


  return