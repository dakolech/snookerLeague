angular.module('snookerLeague').controller "playersIndexController", [
  '$scope', 'flash', 'ngDialog', 'httpPlayer'
  ($scope, flash, ngDialog, httpPlayer) ->


    $scope.query = ''
    $scope.reverse = true

    Allplayers = []
    totalPages = 0
    page = 0
    perPage = 20

    $scope.getAll = ->
      httpPlayer.getAll().then (dataResponse) ->
        Allplayers = dataResponse.data.players
        $scope.changePage(1)


    $scope.getAll()

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
      httpPlayer.getAllWithQuery($scope.query).then (dataResponse) ->
        Allplayers = dataResponse.data.players
      $scope.changePage(1)


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

    $scope.deletePlayer = (playerId) ->
      indexPlayer = -1
      for player, index in Allplayers
        if player.id == playerId
          indexPlayer = index
      if confirm('Are you sure you want to delete '+ Allplayers[indexPlayer].firstname + ' ' + Allplayers[indexPlayer].lastname + '?')
        httpPlayer.deleteOne(playerId).then (dataResponse) ->
          flash('Player ' + Allplayers[indexPlayer].firstname + ' ' + Allplayers[indexPlayer].lastname + ' was successfully deleted.')
          Allplayers.splice(indexPlayer, 1)
          $scope.changePage(page)


    $scope.addNewPlayer = ->
      dialog = ngDialog.open
        template: "newPlayer"
        controller: [
          '$scope', 'httpPlayer'
          ($scope, httpPlayer) ->
            $scope.player
            $scope.formClicked = false
            $scope.tittle = 'Create new'
            $scope.buttonTittle = 'Create'

            $scope.createForm = () ->
              httpPlayer.createOne($scope.player).then (dataResponse) ->
                $scope.player = dataResponse.data
                $scope.player.delete = true
                $scope.closeThisDialog($scope.player)
        ]

      dialog.closePromise.then (data) ->
        if data.value.firstname
          Allplayers.push(data.value)
          $scope.changePage(page)
          flash('Player ' + data.value.firstname + ' ' + data.value.lastname + ' was successfully created.')
          return

]