angular.module('snookerLeague').controller "playerController", [
  '$scope', '$routeParams', 'flash', 'ngDialog', 'httpPlayer'
  ($scope, $routeParams, flash, ngDialog, httpPlayer) ->

    $scope.player = null;

    httpPlayer.getOne($routeParams.id).then (dataResponse) ->
      $scope.player = dataResponse.data

    $scope.editPlayer = ->
      dialog = ngDialog.open
        template: "newPlayer"
        scope: $scope
        controller: [
          '$scope', 'httpPlayer'
          ($scope, httpPlayer) ->
            $scope.player
            $scope.formClicked = false
            $scope.tittle = 'Edit'
            $scope.buttonTittle = 'Update'

            $scope.createForm = () ->
              httpPlayer.updateOne($scope.player).then (dataResponse) ->
                $scope.player = dataResponse.data
              $scope.closeThisDialog($scope.player)
        ]

      dialog.closePromise.then (data) ->
        if data.value.firstname
          flash('Player ' + data.value.firstname + ' ' + data.value.lastname + ' was successfully edited.')
          return
]