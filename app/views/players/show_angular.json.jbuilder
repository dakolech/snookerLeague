json.player do
  json.id @player.id
  json.firstname @player.firstname
  json.lastname @player.lastname
  json.max_break @player.max_break
  json.email @player.email
  json.date_of_birth @player.date_of_birth
  json.city @player.city
  json.phone_number @player.phone_number
end