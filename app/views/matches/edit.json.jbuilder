json.match do
  json.date @match.date
  json.player_1_frames @match.player_1_frames
  json.player_2_frames @match.player_2_frames
  if @match.player_1
    json.player_1 do
      json.id @match.player_1.id
      json.name @match.player_1.full_name
    end
  end
  if @match.player_2
    json.player_2 do
      json.id @match.player_2.id
      json.name @match.player_2.full_name
    end
  end

  json.frames @match.frames do |frame|
    json.id frame.id
    json.player_1_points frame.player_1_points
    json.player_2_points frame.player_2_points

    json.breaks_1 frame.breaks.where(player_id: @match.player_1.id) do |breaK|
      json.id breaK.id
      json.points breaK.points
    end

    json.breaks_2 frame.breaks.where(player_id: @match.player_2.id) do |breaK|
      json.id breaK.id
      json.points breaK.points
    end

  end

end