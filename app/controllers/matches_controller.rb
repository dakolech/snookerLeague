class MatchesController < ApplicationController
  def show
  end

  def edit
    @match = Match.find(params[:id])
  end


  def update
    match = Match.find(params[:id])

    match.update(match_params)

    render :json => match.to_json(:only => [:date, :player_1_frames, :player_2_frames])
  end

  def update_players
    match = Match.find(params[:id])
    player = Player.find(params[:player])
    if params[:which] == '1'
      match.player_1 = player
      match.save
    else
      match.player_2 = player
      match.save
    end

    player.firstname = player.full_name

    render :json => player.to_json(:only => [ :id, :firstname ])

  end

  private
    def match_params
      params.require(:match).permit(:date, :player_1_frames, :player_2_frames)
    end

end
