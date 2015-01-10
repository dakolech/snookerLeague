class League < ActiveRecord::Base
  has_and_belongs_to_many :players, :join_table => 'leagues_players'
  has_many :tables, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_winners, presence: true
  validates :number_of_dropots, presence: true
  validates :best_of, presence: true
  validates :win_points, presence: true
  validates :loss_points, presence: true

  def generate_empty_rounds
    self.rounds.destroy_all
    self.tables.destroy_all

    number_of_rounds = self.players.size - 1
    number_of_matches = (number_of_rounds+1)/2

    number_of_rounds.times do |number|
      round = Round.create!(start_date: self.start_date,
                            end_date: self.end_date,
                            number: number + 1)

      number_of_matches.times do |number2|
        match = Match.create!(date: self.start_date,
                              player_1_frames: 0,
                              player_2_frames: 0)

        generate_frames(match, self.best_of)

        round.matches << match
      end

      self.rounds << round
    end

    generate_tables()

  end

  def generate_filled_rounds
    self.rounds.destroy_all
    self.tables.destroy_all

    number_of_rounds = self.players.size - 1
    number_of_matches = (number_of_rounds+1)/2

    first_array = self.players.take(number_of_matches)
    second_array = self.players.drop(number_of_matches)

    number_of_rounds.times do |number|
      round = Round.create!(start_date: self.start_date,
                            end_date: self.end_date,
                            number: number + 1)

      number_of_matches.times do |number2|
        match = Match.create!(date: self.start_date,
                              player_1_frames: 0,
                              player_2_frames: 0)

        if number <= number_of_rounds/2 && number2 == 0
          match.player_1 = second_array[number2]
          match.player_2 = first_array[number2]
        else
          match.player_1 = first_array[number2]
          match.player_2 = second_array[number2]
        end

        generate_frames(match, self.best_of)

        round.matches << match
      end

      last_from_first_array = first_array.pop
      first_from_second_array = second_array.shift
      second_array << last_from_first_array
      first_array.insert(1, first_from_second_array)

      self.rounds << round
    end

    generate_tables()

  end

  def generate_frames (match, best_of)
    best_of.times do |number3|
      frame = Frame.create!(player_1_points: 0,
                            player_2_points: 0)

      match.frames << frame
    end
  end

  def generate_tables
    self.players.each do |player|
      table = Table.create!(position: 0,
                            number_of_matches: 0,
                            points: 0,
                            number_of_wins: 0,
                            number_of_loss:0,
                            number_of_win_frames: 0,
                            number_of_lose_frames: 0,
                            number_of_win_small_points: 0,
                            number_of_lose_small_points: 0)
      table.player = player

      self.tables << table
    end
  end

  def update_tables(player)

    table = self.tables.find_by(player_id: player.id)


    table.position = 0
    table.number_of_matches = 0
    table.points = 0
    table.number_of_wins = 0
    table.number_of_loss = 0
    table.number_of_win_frames = 0
    table.number_of_lose_frames = 0
    table.number_of_win_small_points = 0
    table.number_of_lose_small_points = 0

    self.rounds.each do |round|
      round.matches.where(player_1_id: player.id).each do |match|

        if match.player_1_frames > match.player_2_frames
          table.number_of_matches += 1
          table.number_of_wins += 1
          table.points += self.win_points
        elsif match.player_2_frames > match.player_1_frames
          table.number_of_matches += 1
          table.number_of_loss += 1
          table.points += self.loss_points
        end

        match.frames.each do |frame|
          if frame.player_1_points > frame.player_2_points
            table.number_of_win_frames += 1
            table.number_of_win_small_points += frame.player_1_points
            table.number_of_lose_small_points += frame.player_2_points
          elsif frame.player_2_points > frame.player_1_points
            table.number_of_lose_frames += 1
            table.number_of_win_small_points += frame.player_1_points
            table.number_of_lose_small_points += frame.player_2_points
          end
        end
      end

      round.matches.where(player_2_id: player.id).each do |match|

        if match.player_1_frames < match.player_2_frames
          table.number_of_matches += 1
          table.number_of_wins += 1
          table.points += self.win_points
        elsif match.player_1_frames > match.player_2_frames
          table.number_of_matches += 1
          table.number_of_loss += 1
          table.points += self.loss_points
        end

        match.frames.each do |frame|
          if frame.player_1_points < frame.player_2_points
            table.number_of_win_frames += 1
            table.number_of_win_small_points += frame.player_2_points
            table.number_of_lose_small_points += frame.player_1_points
          elsif frame.player_1_points > frame.player_2_points
            table.number_of_lose_frames += 1
            table.number_of_win_small_points += frame.player_2_points
            table.number_of_lose_small_points += frame.player_1_points
          end
        end
      end
    end
    table.diff_small_points = table.number_of_win_small_points - table.number_of_lose_small_points
    table.save
  end

  def update_positions
    self.tables.order(points: :desc, diff_small_points: :desc).each_with_index do |table, i|
      table.position = i + 1

      table.save
    end
  end

  def add_bye
    if self.players.size%2 == 1
      bye = Player.create!(firstname:     "Bye",
                           date_of_birth: self.start_date,
                           phone_number:  0,
                           max_break:     0)
      self.players << bye
    end
  end
  def remove_bye
    if self.players.size%2 == 1
      self.players.where(:firstname => "Bye").destroy_all
    end
    Player.where(:firstname => "Bye").destroy_all
  end
end