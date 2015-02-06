app = angular.module('snookerLeague')

app.directive 'loading', ->
  {
  restrict: 'E',
  templateUrl: 'shared/loading.html'
  }

app.directive 'pagination', ->
  {
  restrict: 'E',
  templateUrl: 'shared/pagination.html'
  }