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

  end

  def generate_filled

  end

  def edit_all
    @league = League.find(params[:id])
    @rounds = @league.rounds
    @players = @league.players
  end
end
