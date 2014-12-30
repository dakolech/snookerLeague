json.league do
  json.name @league.name
  json.rounds @league.rounds do |round|
    json.number round.number
    json.start_date round.start_date
    json.end_date round.end_date
    json.matches round.matches do |match|
      json.date match.date
      if match.player_1
        json.player_1 do
          json.firstname match.player_1.firstname
        end
      end
      if match.player_2
        json.player_2 do
          json.firstname match.player_2.firstname
        end
      end
    end
  end
  json.players @league.players do |player|
    json.name player.full_name
  end
end