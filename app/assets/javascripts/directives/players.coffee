app = angular.module('snookerLeague')

app.directive 'formPlayer', ->
  {
  restrict: 'E',
  templateUrl: 'players/form.html'
  }
