angular.module('snookerLeague').service 'frameService', () ->

  @pointsInFrameAreCorrect = (frame) ->
    if frame.player_1_points >=0 && frame.player_1_points<=155 && frame.player_2_points >=0 && frame.player_2_points<=155
      true
    else
      false

  @deleteBreak = (breaks, breakId) ->
    indexBreak = findBreakIndex(breaks, breakId)
    breaks.splice(indexBreak, 1)
    breaks

  findBreakIndex = (breaks, breakId) ->
    for breaK, index in breaks
      if breaK.id == breakId
        return index
    -1

  return