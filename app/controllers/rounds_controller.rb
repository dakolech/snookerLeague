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
    round = Round.find(params[:id])

    round.update(round_params)

    render :json => round.to_json(:only => [ :id, :start_date, :end_date, :number])
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
      league.tables.destroy_all

      number_of_rounds = league.players.size - 1
      number_of_matches = (number_of_rounds+1)/2

      number_of_rounds.times do |number|
        round = Round.create!(start_date: league.start_date,
                              end_date: league.end_date,
                              number: number + 1)

        number_of_matches.times do |number2|
          match = Match.create!(date: league.start_date,
                                player_1_frames: 0,
                                player_2_frames: 0)

          generate_frames(match, league.best_of)

          round.matches << match
        end

        league.rounds << round
      end

      generate_tables(league)

    end

    def generate_filled_rounds(league)
      league.rounds.destroy_all
      league.tables.destroy_all

      number_of_rounds = league.players.size - 1
      number_of_matches = (number_of_rounds+1)/2

      first_array = league.players.take(number_of_matches)
      second_array = league.players.drop(number_of_matches)

      number_of_rounds.times do |number|
        round = Round.create!(start_date: league.start_date,
                              end_date: league.end_date,
                              number: number + 1)

        number_of_matches.times do |number2|
          match = Match.create!(date: league.start_date,
                                player_1_frames: 0,
                                player_2_frames: 0)

          if number <= number_of_rounds/2 && number2 == 0
            match.player_1 = second_array[number2]
            match.player_2 = first_array[number2]
          else
            match.player_1 = first_array[number2]
            match.player_2 = second_array[number2]
          end

          generate_frames(match, league.best_of)

          round.matches << match
        end

        last_from_first_array = first_array.pop
        first_from_second_array = second_array.shift
        second_array << last_from_first_array
        first_array.insert(1, first_from_second_array)

        league.rounds << round
      end

      generate_tables(league)

    end

    def generate_frames (match, best_of)
      best_of.times do |number3|
        frame = Frame.create!(player_1_points: 0,
                              player_2_points: 0)

        match.frames << frame
      end
    end

    def generate_tables(league)
      league.players.each do |player|
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

        league.tables << table
      end
    end

    def round_params
      params.require(:round).permit(:start_date, :end_date)
    end
end
