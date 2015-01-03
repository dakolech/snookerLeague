json.league_players @league.players do |player|
  json.id player.id
  json.firstname player.firstname
  json.lastname player.lastname
  json.max_break player.max_break
  json.email player.email
end

json.players @players do |player|
  json.id player.id
  json.firstname player.firstname
  json.lastname player.lastname
  json.max_break player.max_break
  json.email player.email
end