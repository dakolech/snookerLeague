angular.module('snookerLeague').controller "leagueEditController", [
  '$scope', '$http', '$attrs', 'flash', '$filter'
  ($scope, $http, $attrs, flash, $filter) ->

    $scope.leagueId = $attrs.model
    $scope.reverseL = true

    orderBy = $filter('orderBy');

    $scope.reverse = true

    Allplayers = []
    totalPages = 0
    page = 0
    perPage = 20

    $scope.getAll = ->
      $http.get('leagues/'+$scope.leagueId+'/edit_angular.json')
      .success (data) ->
        $scope.league_players = data.league_players
        #$scope.players = data.players

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

    $http.get('leagues/'+$scope.leagueId+'/edit_angular.json')
    .success (data) ->
      $scope.league_players = data.league_players
      $scope.players = data.players

      $scope.order "id", false
      $scope.orderLeague "id", false
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.addPlayer = (playerId) ->
      $http.patch('/leagues/'+$scope.leagueId+'/add_player/'+playerId,{})
      .success (data) ->
        $scope.league_players = data
        indexPlayer = -1
        for player, index in $scope.players
          if player.id == playerId
            indexPlayer = index

        flash('Player ' + $scope.players[indexPlayer].firstname + ' ' + $scope.players[indexPlayer].lastname + ' was successfully added to league')
        $scope.players.splice(indexPlayer, 1)
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.removePlayer = (playerId) ->
      $http.patch('/leagues/'+$scope.leagueId+'/remove_player/'+playerId,{})
      .success (data) ->
        indexPlayer = -1
        for player, index in $scope.league_players
          if player.id == playerId
            indexPlayer = index
        $scope.players.push($scope.league_players[indexPlayer])
        flash('warning', 'Player ' + $scope.league_players[indexPlayer].firstname + ' ' + $scope.league_players[indexPlayer].lastname + ' was successfully removed from league')
        $scope.league_players = data
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
      $http.get('/players/index_angular.json?search_query='+$scope.query)
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

]