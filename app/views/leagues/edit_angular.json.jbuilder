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
end

json.league_players @league.players do |player|
  json.id player.id
  json.firstname player.firstname.capitalize if player.firstname
  json.lastname player.lastname.capitalize if player.lastname
  json.max_break player.max_break
  json.email player.email
end

json.players @players do |player|
  json.id player.id
  json.firstname player.firstname.capitalize if player.firstname
  json.lastname player.lastname.capitalize if player.lastname
  json.max_break player.max_break
  json.email player.email
end