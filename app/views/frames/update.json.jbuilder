json.player_1_frames @match.player_1_frames
json.player_2_frames @match.player_2_frames
json.frame do
  json.id @frame.id
  json.player_1_points @frame.player_1_points
  json.player_2_points @frame.player_2_points
end
