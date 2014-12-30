class RoundsController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @rounds = Round.where(league_id: params[:league_id])
    @players = League.find(params[:league_id]).players
  end

  def show
  end

  def edit
  end

  def update
  end

  def generate_empty
    league = League.find(params[:id])
    generate_empty_rounds(league)

    redirect_to action: 'edit_all', id: params[:id]
  end

  def generate_filled
    league = League.find(params[:id])
    generate_filled_rounds(league)

    redirect_to action: 'edit_all', id: params[:id]
  end

  def edit_all
    @league = League.find(params[:id])
    @rounds = @league.rounds
    @players = @league.players
    @matches = 0
    @rounds.each do |round|
      @matches += round.matches.size
    end
  end

  def edit_all_angular
    @league = League.find(params[:id])
  end

  private
    def generate_empty_rounds(league)
      league.rounds.destroy_all

      number_of_rounds = league.players.size - 1
      number_of_matches = (number_of_rounds+1)/2

      number_of_rounds.times do |number|
        round = Round.create!(start_date: league.start_date,
                              end_date: league.end_date,
                              number: number + 1)

        number_of_matches.times do |number2|
          match = Match.create!(date: league.start_date)
          round.matches << match
        end

        league.rounds << round
      end
    end

    def generate_filled_rounds(league)
      league.rounds.destroy_all

      number_of_rounds = league.players.size - 1
      number_of_matches = (number_of_rounds+1)/2

      first_array = league.players.take(number_of_matches)
      second_array = league.players.drop(number_of_matches)

      number_of_rounds.times do |number|
        round = Round.create!(start_date: league.start_date,
                              end_date: league.end_date,
                              number: number + 1)

        number_of_matches.times do |number2|
          match = Match.create!(date: league.start_date)

          if number <= number_of_rounds/2 && number2 == 0
            match.player_1 = second_array[number2]
            match.player_2 = first_array[number2]
          else
            match.player_1 = first_array[number2]
            match.player_2 = second_array[number2]
          end

          round.matches << match
        end

        last_from_first_array = first_array.pop
        first_from_second_array = second_array.shift
        second_array << last_from_first_array
        first_array.insert(1, first_from_second_array)

        league.rounds << round
      end
    end
end
