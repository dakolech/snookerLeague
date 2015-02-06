app = angular.module('snookerLeague')

app.directive 'formLeague', ->
  {
    restrict: 'E',
    templateUrl: 'leagues/form.html'
  }

app.directive 'tableLeague', ->
  {
  restrict: 'E',
  templateUrl: 'leagues/table.html'
  }

app.directive 'breaksLeague', ->
  {
  restrict: 'E',
  templateUrl: 'leagues/breaks.html'
  }

app.directive 'breaksOneFrame', ->
  {
  restrict: 'E',
  templateUrl: 'leagues/breaks1InFrame.html'
  }

app.directive 'breaksTwoFrame', ->
  {
  restrict: 'E',
  templateUrl: 'leagues/breaks2InFrame.html'
  }
