json.leagues @leagues do |league|
  json.partial! 'league', league: league
end
