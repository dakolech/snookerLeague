json.leagues @leagues do |league|
  json.id league.id
  json.name league.name
  json.start_date league.start_date
  json.end_date league.end_date
  json.number_of_players league.players.size
  json.best_of league.best_of
end
