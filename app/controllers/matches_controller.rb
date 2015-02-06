class MatchesController < ApplicationController
  before_action :find_match, only: [:edit, :update, :update_player]

  def edit
  end

  def update
    @match.update(match_params)
  end

  def update_player
    @player = Player.find(params[:player])
    if params[:which] == '1'
      @match.player_1 = @player
      @match.save
    else
      @match.player_2 = @player
      @match.save
    end
  end

  private
    def match_params
      params.require(:match).permit(:date, :player_1_frames, :player_2_frames)
    end

    def find_match
      @match = Match.find(params[:id])
    end

end
