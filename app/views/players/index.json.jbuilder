json.players @players do |player|
  if player.firstname != 'bye'
    json.id player.id
    json.firstname player.firstname.capitalize if player.firstname
    json.lastname player.lastname.capitalize if player.lastname
    json.max_break player.max_break
    json.email player.email
    if player.leagues.empty?
      json.delete true
    end
  end
end
