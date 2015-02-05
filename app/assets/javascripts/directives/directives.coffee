angular.module('snookerLeague').directive 'formLeague', ->

  {
    restrict: 'E',
    scope:
      tittle: '='
      #'button-tittle': '='
  link: (scope, element, attrs) ->
    element.text(scope.tittle)

  templateUrl: 'leagues/form.html'
  }
