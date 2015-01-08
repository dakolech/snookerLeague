angular.module('snookerLeague').controller "playerController", [
  '$scope', '$http', '$attrs', 'flash', 'ngDialog'
  ($scope, $http, $attrs, flash, ngDialog) ->

    $scope.playerId = $attrs.model

    $http.get('players/'+$scope.playerId+'/show_angular.json')
    .success (data) ->
      $scope.player = data.player
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

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

            $scope.createForm = () ->
              $http.patch "/players/"+$scope.player.id,
                player:
                  firstname: $scope.player.firstname
                  lastname: $scope.player.lastname
                  email: $scope.player.email
                  date_of_birth: $scope.player.date_of_birth
                  max_break: $scope.player.max_break
                  phone_number: $scope.player.phone_number
                  city: $scope.player.city
              .success (data) ->
                $scope.player.id = data.id
                $scope.player.firstname = data.firstname
                $scope.player.lastname = data.lastname
                $scope.player.email = data.email
                $scope.player.max_break = data.max_break
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