# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def rand_in_range(from, to)
  rand * (to - from) + from
end

(1..50).each do |i|
  Player.create!(firstname:     Faker::Name.first_name,
                 lastname:      Faker::Name.last_name,
                 email:         Faker::Internet.free_email,
                 date_of_birth: rand(50.years).ago,
                 phone_number:  rand_in_range(600000000, 899999999).to_i,
                 max_break:     rand_in_range(18, 147).to_i,
                 city:          Faker::Address.city)
end
