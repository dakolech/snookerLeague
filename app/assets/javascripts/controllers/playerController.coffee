angular.module('snookerLeague').controller "playerController", [
  '$scope', '$http', '$routeParams', 'flash', 'ngDialog'
  ($scope, $http, $routeParams, flash, ngDialog) ->

    $scope.playerId = $routeParams.id

    $scope.border = 10;

    $http.get('api/players/'+$scope.playerId+'.json')
    .success (data) ->
      $scope.player = data.player
      return
    .error (data) ->
      console.log('Error: ' + data)
      return


    $scope.countBreaks = (border) ->
      if border > 0
        $http.get('api/players/'+$scope.playerId+'/number_of_breaks_angular/'+border)
        .success (data) ->
          $scope.breaks = data[0].countbreaks
          return
        .error (data) ->
          console.log('Error: ' + data)
          return

    $scope.countBreaks($scope.border)

    $scope.editPlayer = ->
      dialog = ngDialog.open
        template: "newPlayer"
        scope: $scope
        controller: [
          "$scope"
          "$http"
          ($scope, $http) ->
            $scope.player
            $scope.formClicked = false
            $scope.tittle = 'Edit'
            $scope.buttonTittle = 'Update'

            $scope.updateBreak = () ->
              $http.get('api/players/'+$scope.playerId+'/update_break_angular/')
              .success (data) ->
                $scope.player.max_break = data.max_break
                return
              .error (data) ->
                console.log('Error: ' + data)
                return

            $scope.createForm = () ->
              $http.patch "api/players/"+$scope.player.id,
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
                return
              .error (data) ->
                console.log('Error: ' + data)
                return
              $scope.closeThisDialog($scope.player)
        ]

      dialog.closePromise.then (data) ->
        if data.value.firstname
          flash('Player ' + data.value.firstname + ' ' + data.value.lastname + ' was successfully edited.')
          return
]