angular.module('snookerLeague').controller "matchEditController", [
  '$scope', '$routeParams', 'flash', 'httpMatch', 'httpFrame', 'httpBreak', 'frameService'
  ($scope, $routeParams, flash, httpMatch, httpFrame, httpBreak, frameService) ->

    httpMatch.getEdit($routeParams.match_id).then (dataResponse) ->
      $scope.match = dataResponse.data

    $scope.updateMatchDate = ->
      httpMatch.updateOne($scope.match).then (dataResponse) ->
        $scope.match.date = dataResponse.data.date

    $scope.saveFrame = (frameIndex, frame) ->
      if frameService.pointsInFrameAreCorrect(frame)
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
        if which_player == 1
          $scope.match.frames[which_frame].breaks_1 = frameService.deleteBreak($scope.match.frames[which_frame].breaks_1, breakId)
        else
          $scope.match.frames[which_frame].breaks_2 = frameService.deleteBreak($scope.match.frames[which_frame].breaks_2, breakId)



]