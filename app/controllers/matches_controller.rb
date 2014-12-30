class MatchesController < ApplicationController
  def show
  end

  def edit
  end

  def update
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

end
