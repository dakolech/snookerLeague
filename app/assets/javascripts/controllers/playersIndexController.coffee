angular.module('snookerLeague').controller "playersIndexController", [
  '$scope', 'flash', 'ngDialog', 'httpPlayer', 'pagination',
  ($scope, flash, ngDialog, httpPlayer, pagination) ->

    $scope.query = ''
    $scope.reverse = true
    Allplayers = []
    perPage = 20

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
      $scope.changePage(pagination.page+1)

    $scope.prevPage = ->
      $scope.changePage(pagination.page-1)

    $scope.sort = (sortBy, reverse) ->
      pagination.sort(sortBy, reverse)
      $scope.changePage(1)

    $scope.deletePlayer = (playerId) ->
      player = pagination.findWithId(playerId)
      if confirm('Are you sure you want to delete '+ player.firstname + ' ' + player.lastname + '?')
        httpPlayer.deleteOne(playerId).then (dataResponse) ->
          pagination.deleteWithId(playerId)
          $scope.players = pagination.initData(pagination.allData, perPage)
          updateClasses()
          flash('Player ' + dataResponse.data.name + ' was successfully deleted.')

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
          pagination.addOne(data.value)
          $scope.players = pagination.initData(pagination.allData, perPage)
          updateClasses()
          flash('Player ' + data.value.firstname + ' ' + data.value.lastname + ' was successfully created.')
          return

]