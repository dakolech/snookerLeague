angular.module('snookerLeague').controller "matchEditController", [
  '$scope', '$http', '$attrs'
  ($scope, $http, $attrs) ->

    $scope.leagueId = $attrs.model1
    $scope.roundId = $attrs.model2
    $scope.matchId = $attrs.model3



    $http.get('leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/edit_angular.json')
    .success (data) ->
      $scope.match = data.match
      return
    .error (data) ->
      console.log('Error: ' + data)
      return

    $scope.updateMatchDate = (date) ->
      $http.patch('/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId, {match: {date: date, id: $scope.matchId}})
      .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.saveFrame = (id, player_1_points, player_2_points) ->
      $http.patch('/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+id,
        {frame: {player_1_points: player_1_points, player_2_points: player_2_points, id: id}})
      .success (data) ->
        $scope.match.player_1_frames = data.player_1_frames
        $scope.match.player_2_frames = data.player_2_frames
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.addBreak = (playerId, frameId, which_player, which_frame) ->
      $http.post('/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+frameId+'/breaks',
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
      $http.patch('/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+frameId+'/breaks/'+breakId,
        {break: {points: points}})
      .success (data) ->
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.deleteBreak = (breakId, frameId, which_player, which_frame) ->
      $http.delete('/leagues/'+$scope.leagueId+'/rounds/'+$scope.roundId+'/matches/'+$scope.matchId+'/frames/'+frameId+'/breaks/'+breakId)
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