angular.module('snookerLeague').controller "playersIndexController", [
  '$scope', 'flash', 'ngDialog', 'httpPlayer', 'pagination',
  ($scope, flash, ngDialog, httpPlayer, pagination) ->

    $scope.query = ''
    $scope.reverse = true
    Allplayers = []
    perPage = 10

    updateClasses = ->
      $scope.pageClass = pagination.pageClass
      $scope.prevClass = pagination.prevClass
      $scope.nextClass = pagination.nextClass

    $scope.getAll = ->
      httpPlayer.getAll().then (dataResponse) ->
        Allplayers = dataResponse.data.players
        $scope.players = pagination.initData(Allplayers, perPage)
        updateClasses()

    $scope.getAll()

    $scope.searchClick = ->
      httpPlayer.getAllWithQuery($scope.query).then (dataResponse) ->
        Allplayers = dataResponse.data.players
        $scope.players = pagination.initData(Allplayers, perPage)

    $scope.range = () ->
      new Array(pagination.totalPages)

    $scope.changePage = (number) ->
      $scope.players = pagination.changePage(number)
      updateClasses()

    $scope.nextPage = ->
      $scope.players = pagination.changePage(pagination.page+1)
      updateClasses()

    $scope.prevPage = ->
      $scope.players = pagination.changePage(pagination.page-1)
      updateClasses()

    $scope.sort = (sortBy, reverse) ->
      pagination.sort(sortBy, reverse)
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