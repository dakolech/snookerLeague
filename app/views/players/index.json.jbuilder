json.players @players do |player|
  if player.firstname != 'bye'
    json.partial! 'playerInfo', player: player
    if player.leagues.empty?
      json.delete true
    end
  end
end
