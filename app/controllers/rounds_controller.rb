class RoundsController < ApplicationController
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
    league.rounds.destroy_all
    league.update_column :bye, false

    number_of_rounds = league.players.size - 1
    number_of_matches = ((number_of_rounds+1.0)/2).ceil
    if number_of_matches > (number_of_rounds+1.0)/2
      league.update_column :bye, true
    end
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

    redirect_to action: 'edit_all', id: params[:id]
  end

  def generate_filled

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
end
