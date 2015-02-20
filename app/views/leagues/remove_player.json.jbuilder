json.players @league.players do |player|
  json.partial! 'league_players', player: player
end