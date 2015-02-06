angular.module('snookerLeague').controller "playersIndexController", [
  '$scope', '$http', 'flash', 'ngDialog'
  ($scope, $http, flash, ngDialog) ->

    $scope.reverse = true

    Allplayers = []
    totalPages = 0
    page = 0
    perPage = 20

    $scope.getAll = ->
      $scope.query = ''
      $http.get('api/players/index.json')
      .success (data) ->
        Allplayers = data.players
        $scope.changePage(1)
        $scope.pageClass[0] = 'active'
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

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
      $http.get('api/players/index.json?search_query='+$scope.query)
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

    $scope.deletePlayer = (playerId) ->
      indexPlayer = -1
      for player, index in Allplayers
        if player.id == playerId
          indexPlayer = index
      if confirm('Are you sure you want to delete '+ Allplayers[indexPlayer].firstname + ' ' + Allplayers[indexPlayer].lastname + '?')
        console.log playerId
        $http.delete('api/players/'+ playerId)
        .success (data) ->
          flash('Player ' + Allplayers[indexPlayer].firstname + ' ' + Allplayers[indexPlayer].lastname + ' was successfully deleted.')
          Allplayers.splice(indexPlayer, 1)
          $scope.changePage(page)
          return
        .error (data) ->
          console.log('Error: ' + data)
          return


    $scope.addNewPlayer = ->
      dialog = ngDialog.open
        template: "newPlayer"
        controller: [
          "$scope"
          "$http"
          ($scope, $http) ->
            $scope.player
            $scope.formClicked = false
            $scope.tittle = 'Create new'
            $scope.buttonTittle = 'Create'

            $scope.createForm = () ->
              $http.post "api/players",
                player:
                  firstname: $scope.player.firstname
                  lastname: $scope.player.lastname
                  email: $scope.player.email
                  date_of_birth: $scope.player.date_of_birth
                  max_break: $scope.player.max_break
                  phone_number: $scope.player.phone_number
                  city: $scope.player.city
              .success (data) ->
                $scope.player.id = data.player.id
                $scope.player.firstname = data.player.firstname
                $scope.player.lastname = data.player.lastname
                $scope.player.email = data.player.email
                $scope.player.max_break = data.player.max_break
                $scope.player.delete = true
                return
              .error (data) ->
                console.log('Error: ' + data)
                return
              $scope.closeThisDialog($scope.player)
        ]

      dialog.closePromise.then (data) ->
        if data.value.firstname
          Allplayers.push(data.value)
          $scope.changePage(page)
          flash('Player ' + data.value.firstname + ' ' + data.value.lastname + ' was successfully created.')
          return

]