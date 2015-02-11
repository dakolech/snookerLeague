angular.module('snookerLeague').controller "leaguesIndexController", [
  '$scope', 'flash', 'ngDialog', '$filter', 'httpLeague'
  ($scope, flash, ngDialog, $filter, httpLeague) ->

    $scope.reverse = true
    $scope.query = ''

    orderBy = $filter('orderBy');

    $scope.orderLeague = (predicate, reverse) ->
      $scope.leagues = orderBy($scope.leagues, predicate, reverse)
      return

    httpLeague.getAll($scope.query).then (dataResponse) ->
      $scope.leagues = dataResponse.data.leagues
      $scope.orderLeague "id", false

    $scope.deleteLeague = (leagueId) ->
      indexLeague = -1
      for league, index in $scope.leagues
        if league.id == leagueId
          indexLeague = index
      if confirm('Are you sure you want to delete '+ $scope.leagues[indexLeague].name + '?')
        httpLeague.deleteOne(leagueId).then (dataResponse) ->
          $scope.leagues.splice(indexLeague, 1)
          flash('League ' + dataResponse.data.name + ' was successfully deleted.')

    $scope.addNewLeague = ->
      dialog = ngDialog.open
        template: "newLeague"
        controller: [
          '$scope', 'httpLeague'
          ($scope, httpLeague) ->
            $scope.formClicked = false
            $scope.tittle = 'Create new'
            $scope.buttonTittle = 'Create'

            $scope.createForm = () ->
              httpLeague.createOne($scope.league).then (dataResponse) ->
                $scope.league = dataResponse.data
                $scope.closeThisDialog($scope.league)
        ]

      dialog.closePromise.then (data) ->
        if data.value.name
          $scope.leagues.push(data.value)
          flash('League ' + data.value.name + ' was successfully created.')
          return

]