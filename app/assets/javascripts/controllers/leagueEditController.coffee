angular.module('snookerLeague').controller "leagueEditController", [
  '$scope', '$http', '$routeParams', 'flash', '$filter', 'ngDialog'
  ($scope, $http, $routeParams, flash, $filter, ngDialog) ->

    $scope.reverseL = true

    orderBy = $filter('orderBy');

    $scope.reverse = true

    Allplayers = []
    totalPages = 0
    page = 0
    perPage = 20

    $scope.getAll = ->
      $http.get('api/leagues/'+$routeParams.id+'/edit.json')
      .success (data) ->
        $scope.league_players = data.league_players
        $scope.league = data.league

        Allplayers = data.players
        $scope.changePage(1)
        $scope.pageClass[0] = 'active'
        $scope.orderLeague "id", false
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.getAll()

    $scope.orderLeague = (predicate, reverse) ->
      $scope.league_players = orderBy($scope.league_players, predicate, reverse)
      return

    $scope.addPlayer = (playerId) ->
      $http.patch('api/leagues/'+$routeParams.id+'/add_player/'+playerId,{})
      .success (data) ->
        $scope.league_players = data.players
        indexPlayer = -1
        for player, index in Allplayers
          if player.id == playerId
            indexPlayer = index

        flash('Player ' + Allplayers[indexPlayer].firstname + ' ' + Allplayers[indexPlayer].lastname + ' was successfully added to league')
        Allplayers.splice(indexPlayer, 1)
        $scope.changePage(page)
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.removePlayer = (playerId) ->
      $http.patch('api/leagues/'+$routeParams.id+'/remove_player/'+playerId,{})
      .success (data) ->
        indexPlayer = -1
        for player, index in $scope.league_players
          if player.id == playerId
            indexPlayer = index
        Allplayers.push($scope.league_players[indexPlayer])
        flash('warning', 'Player ' + $scope.league_players[indexPlayer].firstname + ' ' + $scope.league_players[indexPlayer].lastname + ' was successfully removed from league')
        $scope.league_players = data.players
        $scope.changePage(page)
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.range = () ->
      new Array(totalPages)

    $scope.changePage = (number) ->
      page = number
      $scope.updatePages()
      $scope.pageClass[number-1] = 'active'


    $scope.updatePages = ->
      totalEntries = Allplayers.length
      totalPages = Math.ceil(Allplayers.length/perPage)
      start = (page-1)*perPage
      end = (page)*perPage
      $scope.players = Allplayers.slice(start, end);
      $scope.pageClass = new Array(totalPages)
      if (page < totalPages)
        $scope.prevClass = ""
      else
        $scope.nextClass = "disabled"
      if (page >= 1)
        $scope.nextClass = ""
      else
        $scope.prevClass = "disabled"
      if (page == 1)
        $scope.prevClass = "disabled"
      if (page == totalPages || totalPages < 1)
        $scope.nextClass = "disabled"

    $scope.searchClick = ->
      $http.get('api/leagues/'+$routeParams.id+'/edit.json?search_query='+$scope.query)
      .success (data) ->
        Allplayers = data.players
        $scope.changePage(1)
        $scope.pageClass[0] = 'active'
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.nextPage = ->
      if (page < totalPages)
        $scope.changePage(page+1)
        $scope.prevClass = ""
      else
        $scope.nextClass = "disabled"
      if (page == totalPages)
        $scope.nextClass = "disabled"

    $scope.prevPage = ->
      if (page > 1)
        $scope.changePage(page-1)
        $scope.nextClass = ""
      else
        $scope.prevClass = "disabled"
      if (page == 1)
        $scope.prevClass = "disabled"

    dynamicSort = (property) ->
      sortOrder = 1
      if property[0] is "-"
        sortOrder = -1
        property = property.substr(1)
      (a, b) ->
        result = (if (a[property] < b[property]) then -1 else (if (a[property] > b[property]) then 1 else 0))
        result * sortOrder

    $scope.sort = (sortBy, reverse) ->
      if reverse
        sortBy = '-' + sortBy
      Allplayers.sort(dynamicSort(sortBy))
      $scope.changePage(1)

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
          flash('League ' + data.value.name + ' was successfully edited.')
          return

]