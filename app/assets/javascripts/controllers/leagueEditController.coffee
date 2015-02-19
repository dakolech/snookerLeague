angular.module('snookerLeague').controller "leagueEditController", [
  '$scope', '$routeParams', 'flash', '$filter', 'ngDialog', 'pagination', 'httpLeague', 'leagueService'
  ($scope, $routeParams, flash, $filter, ngDialog, pagination, httpLeague, leagueService) ->

    $scope.reverseL = true
    orderBy = $filter('orderBy');
    $scope.reverse = true
    perPage = 20
    $scope.query = ''

    updateClasses = ->
      $scope.pageClass = pagination.pageClass
      $scope.prevClass = pagination.prevClass
      $scope.nextClass = pagination.nextClass

    $scope.getAll = ->
      httpLeague.getEdit($routeParams.id, $scope.query).then (dataResponse) ->
        $scope.league_players = dataResponse.data.league_players
        $scope.league = dataResponse.data.league
        $scope.players = pagination.initData(dataResponse.data.players, perPage)
        updateClasses()
        $scope.orderLeague "id", false

    $scope.getAll()

    $scope.orderLeague = (predicate, reverse) ->
      $scope.league_players = orderBy($scope.league_players, predicate, reverse)
      return

    $scope.addPlayerToLeague = (playerId) ->
      httpLeague.addPlayer($routeParams.id, playerId).then (dataResponse) ->
        $scope.league_players = dataResponse.data.players
        player = pagination.findWithId(playerId)
        pagination.deleteWithId(playerId)
        $scope.players = pagination.initData(pagination.allData, perPage)
        updateClasses()
        flash('Player ' + player.firstname + ' ' + player.lastname + ' was successfully added to league')

    $scope.removePlayerFromLeague = (playerId) ->
      httpLeague.removePlayer($routeParams.id, playerId).then (dataResponse) ->
        indexPlayer = leagueService.findPlayerIndex($scope.league_players, playerId)
        pagination.addOne($scope.league_players[indexPlayer])
        $scope.players = pagination.initData(pagination.allData, perPage)
        updateClasses()
        flash('warning', 'Player ' + $scope.league_players[indexPlayer].firstname + ' ' + $scope.league_players[indexPlayer].lastname + ' was successfully removed from league')
        $scope.league_players = dataResponse.data.players

    $scope.searchClick = ->
      httpLeague.getEdit($routeParams.id, $scope.query).then (dataResponse) ->
        $scope.players = pagination.initData(dataResponse.data.players, perPage)
        updateClasses()

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
          '$scope', 'httpLeague'
          ($scope, httpLeague) ->
            $scope.formClicked = false
            $scope.tittle = 'Edit'
            $scope.buttonTittle = 'Update'

            $scope.createForm = () ->
              httpLeague.updateOne($scope.league).then (dataResponse) ->
                $scope.league = dataResponse.data
                $scope.closeThisDialog(dataResponse.data)
        ]

      dialog.closePromise.then (data) ->
        if data.value.name
          flash('League ' + data.value.name + ' was successfully edited.')
          return

]