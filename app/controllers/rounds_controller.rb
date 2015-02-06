class RoundsController < ApplicationController
  before_action :find_league, only: [:generate_empty, :generate_filled, :edit_all]

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
    @league.generate_empty_rounds
  end

  def generate_filled
    @league.generate_filled_rounds
  end

  def edit_all
  end


  private
    def round_params
      params.require(:round).permit(:start_date, :end_date)
    end

    def find_league
      @league = League.find(params[:id])
    end
end
