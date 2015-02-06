json.league do
  json.name @league.name
  json.id @league.id
  json.rounds @league.rounds do |round|
    json.id round.id
    json.number round.number
    json.start_date round.start_date
    json.end_date round.end_date
    json.matches round.matches do |match|
      json.id match.id
      json.date match.date
      json.player_1_frames match.player_1_frames
      json.player_2_frames match.player_2_frames
      json.class 'correct'
      if match.player_1
        json.player_1 do
          json.class 'correct'
          json.name match.player_1.full_name
        end
      end
      if match.player_2
        json.player_2 do
          json.class 'correct'
          json.name match.player_2.full_name
        end
      end
    end
  end
  json.players @league.players do |player|
    json.id player.id
    json.name player.full_name
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
  end
end