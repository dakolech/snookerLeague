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
end