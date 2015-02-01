json.players @league.players do |player|
  json.id player.id
  json.firstname player.firstname.capitalize if player.firstname
  json.lastname player.lastname.capitalize if player.lastname
  json.email player.email
  json.max_break player.max_break
end