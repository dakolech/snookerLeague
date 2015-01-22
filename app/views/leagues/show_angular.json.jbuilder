json.league do
  json.id @league.id
  json.name @league.name
  json.start_date @league.start_date
  json.end_date @league.end_date
  json.best_of @league.best_of
  json.number_of_winners @league.number_of_winners
  json.number_of_dropots @league.number_of_dropots
  json.win_points @league.win_points
  json.loss_points @league.loss_points

  json.breaks @breaks do |breaK|
    json.points breaK.points
    json.player breaK.player.full_name
  end

  json.tables @league.tables do |table|
    json.position table.position
    json.name table.player.full_name
    json.number_of_matches table.number_of_matches
    json.points table.points
    json.number_of_wins table.number_of_wins
    json.number_of_loss table.number_of_loss
    json.number_of_win_frames table.number_of_win_frames
    json.number_of_lose_frames table.number_of_lose_frames
    json.number_of_win_small_points table.number_of_win_small_points
    json.number_of_lose_small_points table.number_of_lose_small_points
    json.diff_small_points table.diff_small_points
    json.player_id table.player_id
  end

  json.rounds @league.rounds do |round|
    json.number round.number
    json.start_date round.start_date
    json.end_date round.end_date
    json.matches round.matches do |match|
      json.date match.date
      json.player_1_frames match.player_1_frames
      json.player_2_frames match.player_2_frames
      json.class 'unhidden'

      if match.player_1
        json.player_1 do
          json.id match.player_1.id
          json.name match.player_1.full_name
        end
      end
      if match.player_2
        json.player_2 do
          json.id match.player_2.id
          json.name match.player_2.full_name
        end
      end

      json.frames match.frames do |frame|
        if frame.player_1_points != 0 || frame.player_2_points != 0
          json.id frame.id
          json.player_1_points frame.player_1_points
          json.player_2_points frame.player_2_points

          json.breaks_1 frame.breaks.where(player_id: match.player_1.id) do |breaK|
            json.id breaK.id
            json.points breaK.points
          end

          json.breaks_2 frame.breaks.where(player_id: match.player_2.id) do |breaK|
            json.id breaK.id
            json.points breaK.points
          end
        end
      end
    end
  end
end