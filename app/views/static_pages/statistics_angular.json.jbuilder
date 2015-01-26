json.numberOfPlayers @players
json.numberOfLeagues @leagues
json.numberOfRounds @rounds
json.numberOfMatches @matches
json.numberOfFrames @frames
json.numberOfBreaks @breaks
json.highest_breaks @h_breaks do |breaK|
  json.points breaK.points
  json.name breaK.player.full_name
  json.date breaK.frame.match.date
  json.league breaK.frame.match.round.league.name
end