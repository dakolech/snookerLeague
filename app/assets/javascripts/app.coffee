workshops = angular.module('snookerLeague',[
  'ngRoute'
])

.config( ($routeProvider, $locationProvider) ->
  $routeProvider.when('/leagues/:id/rounds/edit', {
    controller: 'roundsEditController'
  });


  $locationProvider.html5Mode(true);
)
