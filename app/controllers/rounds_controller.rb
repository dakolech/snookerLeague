class RoundsController < ApplicationController
  before_action :find_league, only: [:generate_empty, :generate_filled, :edit_all]

  def edit_all
  end

  def update
    @round = Round.find(params[:id])
    @round.update(round_params)
  end

  def generate_empty
    @league.generate_empty_rounds
  end

  def generate_filled
    @league.generate_filled_rounds
  end

  private
    def round_params
      params.require(:round).permit(:start_date, :end_date)
    end

    def find_league
      @league = League.find(params[:id])
    end
end
