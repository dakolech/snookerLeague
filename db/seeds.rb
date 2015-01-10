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

players = Player.all

(1..5).each do |i|
  start_date = rand(5.years).ago
  end_date = start_date + rand(20.weeks)
  best_of = rand 6
  if best_of%2 == 0
    best_of += 1
  end

  league = League.create!(
            name:               Faker::Lorem.word.capitalize,
            start_date:         start_date,
            end_date:           end_date,
            number_of_winners:  1,
            number_of_dropots:  rand(3) + 1,
            win_points:         rand(2) + 2,
            loss_points:        rand(2),
            best_of:            best_of
  )

  how_many_players = rand(5) + 6
  if how_many_players%2 == 1
    how_many_players -= 1
  end

  (1..how_many_players).each do
    while true do
      player = players[rand(50)]
      break unless league.players.include?(player)
    end
    league.players << player
  end

  league.generate_filled_rounds

  league.rounds.each do |round|
    round.matches.each do |match|
      player_1_frames = 0
      player_2_frames = 0
      max_frames = league.best_of/2 + 1
      match.frames.each do |frame|
        if rand(2) == 0
          frame.player_1_points = rand(127) + 20
          frame.player_2_points = rand(147-frame.player_1_points)
          player_1_frames += 1
        else
          frame.player_2_points = rand(127) + 20
          frame.player_1_points = rand(147-frame.player_2_points)
          player_2_frames += 1
        end

        frame.save

        player_1_breaks = []
        player_2_breaks = []
        player_1_points = frame.player_1_points
        player_2_points = frame.player_2_points

        while player_1_points > 30
          breaK = rand(player_1_points)
          if breaK > 10
            player_1_breaks << breaK
            player_1_points -= breaK
          end
        end

        while player_2_points > 30
          breaK = rand(player_2_points)
          if breaK > 10
            player_2_breaks << breaK
            player_2_points -= breaK
          end
        end

        player_1_breaks.each do |breaks|
          Break.create!(
                   points: breaks,
                   frame_id: frame.id,
                   player_id: match.player_1.id
          )
        end

        player_2_breaks.each do |breaks|
          Break.create!(
              points: breaks,
              frame_id: frame.id,
              player_id: match.player_2.id
          )
        end

        match.update_frames

        if match.player_1_frames == max_frames || match.player_2_frames == max_frames
          break
        end
      end
      match.update_frames
      league.update_tables(match.player_1)
      league.update_tables(match.player_2)
    end
    league.update_positions
  end

end
