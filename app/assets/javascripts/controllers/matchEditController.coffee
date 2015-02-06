angular.module('snookerLeague').controller "matchEditController", [
  '$scope', '$http', '$routeParams', 'flash'
  ($scope, $http, $routeParams, flash) ->

    $scope.leagueId = $routeParams.id
    $scope.roundId = $routeParams.round_id
    $scope.matchId = $routeParams.match_id



    $http.get('api/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/edit.json')
    .success (data) ->
      $scope.match = data.match
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.updateMatchDate = (date) ->
      $http.patch('api/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId, {match: {date: date, id: $scope.matchId}})
      .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.saveFrame = (id, player_1_points, player_2_points) ->
      if player_1_points >=0 && player_1_points<=155 && player_2_points >=0 && player_2_points<=155
        $http.patch('api/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+id,
          {frame: {player_1_points: player_1_points, player_2_points: player_2_points, id: id}})
        .success (data) ->
          $scope.match.player_1_frames = data.player_1_frames
          $scope.match.player_2_frames = data.player_2_frames
          flash('Frame sucessfully updated')
          return
        .error (data) ->
          console.log('Error: ' + data)
          return
      else
        flash('warning','Wrong frame points (must be 0-155)')

    $scope.addBreak = (playerId, frameId, which_player, which_frame) ->
      $http.post('api/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+frameId+'/breaks',
        {break: {player_id: playerId, frame_id: frameId, match_id: $scope.matchId}})
      .success (data) ->
        if which_player == 1
          $scope.match.frames[which_frame].breaks_1.push(data)
        else
          $scope.match.frames[which_frame].breaks_2.push(data)
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.updateBreak = (breakId, frameId, points) ->
      $http.patch('api/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+frameId+'/breaks/'+breakId,
        {break: {points: points}})
      .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.deleteBreak = (breakId, frameId, which_player, which_frame) ->
      $http.delete('api/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+frameId+'/breaks/'+breakId)
      .success (data) ->
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
        return
      .error (data) ->
        console.log('Error: ' + data)
        return


]