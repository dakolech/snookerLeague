angular.module('snookerLeague').controller "leaguesIndexController", [
  '$scope', '$http', 'flash', 'ngDialog', '$filter'
  ($scope, $http, flash, ngDialog, $filter) ->

    $scope.reverse = true

    orderBy = $filter('orderBy');

    $scope.orderLeague = (predicate, reverse) ->
      $scope.leagues = orderBy($scope.leagues, predicate, reverse)
      return

    $http.get('api/leagues/index.json')
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
        $http.delete('api/leagues/'+ leagueId)
        .success (data) ->
          flash('League ' + $scope.leagues[indexLeague].name + ' was successfully deleted.')
          $scope.leagues.splice(indexLeague, 1)
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
            $scope.tittle = 'Create new'
            $scope.buttonTittle = 'Create'

            $scope.createForm = () ->
              $http.post "api/leagues",
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
                $scope.league.id = data.league.id
                $scope.league.name = data.league.name
                $scope.league.start_date = data.league.start_date
                $scope.league.end_date = data.league.end_date
                $scope.league.number_of_players = data.league.number_of_players
                $scope.league.best_of = data.league.best_of
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