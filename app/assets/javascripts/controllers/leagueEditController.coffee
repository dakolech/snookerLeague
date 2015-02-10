angular.module('snookerLeague').controller "leagueEditController", [
  '$scope', '$http', '$routeParams', 'flash', '$filter', 'ngDialog', 'pagination',
  ($scope, $http, $routeParams, flash, $filter, ngDialog, pagination) ->

    $scope.reverseL = true
    orderBy = $filter('orderBy');
    $scope.reverse = true
    perPage = 20

    updateClasses = ->
      $scope.pageClass = pagination.pageClass
      $scope.prevClass = pagination.prevClass
      $scope.nextClass = pagination.nextClass

    $scope.getAll = ->
      $http.get('api/leagues/'+$routeParams.id+'/edit.json')
      .success (data) ->
        $scope.league_players = data.league_players
        $scope.league = data.league

        $scope.players = pagination.initData(data.players, perPage)
        updateClasses()
        $scope.orderLeague "id", false
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.getAll()

    $scope.orderLeague = (predicate, reverse) ->
      $scope.league_players = orderBy($scope.league_players, predicate, reverse)
      return

    $scope.addPlayerToLeague = (playerId) ->
      $http.patch('api/leagues/'+$routeParams.id+'/add_player/'+playerId,{})
      .success (data) ->
        $scope.league_players = data.players

        player = pagination.findWithId(playerId)
        pagination.deleteWithId(playerId)
        $scope.players = pagination.initData(pagination.allData, perPage)
        updateClasses()
        flash('Player ' + player.firstname + ' ' + player.lastname + ' was successfully added to league')
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.removePlayerFromLeague = (playerId) ->
      $http.patch('api/leagues/'+$routeParams.id+'/remove_player/'+playerId,{})
      .success (data) ->
        indexPlayer = -1
        for player, index in $scope.league_players
          if player.id == playerId
            indexPlayer = index

        pagination.addOne($scope.league_players[indexPlayer])
        $scope.players = pagination.initData(pagination.allData, perPage)
        updateClasses()
        flash('warning', 'Player ' + $scope.league_players[indexPlayer].firstname + ' ' + $scope.league_players[indexPlayer].lastname + ' was successfully removed from league')
        $scope.league_players = data.players
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.searchClick = ->
      $http.get('api/leagues/'+$routeParams.id+'/edit.json?search_query='+$scope.query)
      .success (data) ->
        $scope.players = pagination.initData(data.players, perPage)
        updateClasses()
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.range = () ->
      new Array(pagination.totalPages)

    $scope.changePage = (number) ->
      $scope.players = pagination.changePage(number)
      updateClasses()

    $scope.nextPage = ->
      $scope.changePage(pagination.page+1)

    $scope.prevPage = ->
      $scope.changePage(pagination.page-1)

    $scope.editLeague = ->
      dialog = ngDialog.open
        template: "newLeague"
        scope: $scope
        controller: [
          "$scope"
          "$http"
          ($scope, $http) ->
            $scope.league
            $scope.formClicked = false
            $scope.tittle = 'Edit'
            $scope.buttonTittle = 'Update'

            $scope.createForm = () ->
              $http.patch "api/leagues/"+$scope.league.id,
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
          flash('League ' + data.value.name + ' was successfully edited.')
          return

]