json.players @players do |player|
  json.id player.id
  json.firstname player.firstname.capitalize
  json.lastname player.lastname.capitalize
  json.max_break player.max_break
  json.email player.email
  if player.leagues.empty?
    json.delete true
  end
end
