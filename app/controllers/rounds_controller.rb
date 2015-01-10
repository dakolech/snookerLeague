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
    league.generate_empty_rounds

    redirect_to action: 'edit_all', id: params[:id]
  end

  def generate_filled
    league = League.find(params[:id])
    league.generate_filled_rounds

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
    def round_params
      params.require(:round).permit(:start_date, :end_date)
    end
end
