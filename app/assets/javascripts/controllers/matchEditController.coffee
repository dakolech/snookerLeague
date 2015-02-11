angular.module('snookerLeague').controller "matchEditController", [
  '$scope', '$http', '$routeParams', 'flash', 'httpMatch', 'httpFrame', 'httpBreak'
  ($scope, $http, $routeParams, flash, httpMatch, httpFrame, httpBreak) ->

    $scope.leagueId = $routeParams.id
    $scope.roundId = $routeParams.round_id
    $scope.matchId = $routeParams.match_id

    httpMatch.getEdit($routeParams.match_id).then (dataResponse) ->
      $scope.match = dataResponse.data

    $scope.updateMatchDate = ->
      httpMatch.updateOne($scope.match).then (dataResponse) ->
        $scope.match.date = dataResponse.data.date

    $scope.saveFrame = (frameIndex, frame) ->
      if frame.player_1_points >=0 && frame.player_1_points<=155 && frame.player_2_points >=0 && frame.player_2_points<=155
        httpFrame.updateOne($routeParams.match_id, frame).then (dataResponse) ->
          $scope.match.player_1_frames = dataResponse.data.player_1_frames
          $scope.match.player_2_frames = dataResponse.data.player_2_frames
          $scope.match.frames[frameIndex] = dataResponse.data.frame
          flash('Frame '+(frameIndex+1)+' sucessfully updated')
      else
        flash('warning','Wrong frame points (must be 0-155)')

    $scope.addBreak = (playerId, frameId, which_player, which_frame) ->
      httpBreak.createOne($routeParams.match_id, frameId, playerId).then (dataResponse) ->
        if which_player == 1
          $scope.match.frames[which_frame].breaks_1.push(dataResponse.data)
        else
          $scope.match.frames[which_frame].breaks_2.push(dataResponse.data)

    $scope.updateBreak = (breakId, frameId, points) ->
      httpBreak.updateOne($routeParams.match_id, frameId, breakId, points).then (dataResponse) ->
        return

    $scope.deleteBreak = (breakId, frameId, which_player, which_frame) ->
      httpBreak.deleteOne($routeParams.match_id, frameId, breakId).then (dataResponse) ->
        indexBreak = -1
        if which_player == 1
          for breaK, index in $scope.match.frames[which_frame].breaks_1
            if breaK.id == breakId
              indexBreak = index
          $scope.match.frames[which_frame].breaks_1.splice(indexBreak, 1)
        else
          for breaK, index in $scope.match.frames[which_frame].breaks_2
            if breaK.id == breakId
              indexBreak = index
          $scope.match.frames[which_frame].breaks_2.splice(indexBreak, 1)



]