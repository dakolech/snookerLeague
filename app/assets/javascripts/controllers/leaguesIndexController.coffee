angular.module('snookerLeague').controller "leaguesIndexController", [
  '$scope', '$http', 'flash', 'ngDialog', '$filter'
  ($scope, $http, flash, ngDialog, $filter) ->

    $scope.reverse = true

    orderBy = $filter('orderBy');

    $scope.orderLeague = (predicate, reverse) ->
      $scope.leagues = orderBy($scope.leagues, predicate, reverse)
      return

    $http.get('leagues/index_angular.json')
    .success (data) ->
      $scope.leagues = data.leagues
      $scope.orderLeague "id", false
      return
    .error (data) ->
      console.log('Error: ' + data)
      return


    $scope.deleteLeague = (leagueId) ->
      indexLeague = -1
      for league, index in $scope.leagues
        if league.id == leagueId
          indexLeague = index
      if confirm('Are you sure you want to delete '+ $scope.leagues[indexLeague].name + '?')
        $http.delete('/leagues/'+ leagueId)
        .success (data) ->
          flash('League ' + $scope.leagues[indexLeague].name + ' was successfully deleted.')
          $scope.leagues.splice(indexLeague, 1)
          $scope.changePage(page)
          return
        .error (data) ->
          console.log('Error: ' + data)
          return


    $scope.addNewLeague = ->
      dialog = ngDialog.open
        template: "newLeague"
        controller: [
          "$scope"
          "$http"
          ($scope, $http) ->
            $scope.league
            $scope.formClicked = false

            $scope.createForm = () ->
              $http.post "/leagues",
                league:
                  name: $scope.league.name
                  start_date: $scope.league.start_date
                  end_date: $scope.league.end_date
                  number_of_winners: $scope.league.number_of_winners
                  number_of_dropots: $scope.league.number_of_dropots
                  win_points: $scope.league.win_points
                  loss_points: $scope.league.loss_points
                  best_of: $scope.league.best_of
              .success (data) ->
                $scope.league.id = data.id
                $scope.league.name = data.name
                $scope.league.start_date = data.start_date
                $scope.league.end_date = data.end_date
                $scope.league.number_of_players = 0
                $scope.league.best_of = data.best_of
                return
              .error (data) ->
                console.log('Error: ' + data)
                return
              $scope.closeThisDialog($scope.league)
        ]

      dialog.closePromise.then (data) ->
        if data.value.name
          $scope.leagues.push(data.value)
          flash('League ' + data.value.name + ' was successfully created.')
          return

]