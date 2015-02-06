json.player do
  json.id @player.id
  json.firstname @player.firstname.capitalize
  json.lastname @player.lastname.capitalize
  json.max_break @player.max_break
  json.league_break Break.where(player_id: @player.id).maximum("points")
  json.email @player.email
  json.date_of_birth @player.date_of_birth
  json.city @player.city.titleize
  json.phone_number @player.phone_number

  json.breaks @player.breaks.sort_by(&:points).reverse do |breaK|
    json.points breaK.points
    json.league breaK.frame.match.round.league.name
    json.date breaK.frame.match.date
  end
end