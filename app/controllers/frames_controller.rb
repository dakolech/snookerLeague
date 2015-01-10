class FramesController < ApplicationController

  def update
    frame = Frame.find(params[:id])

    frame.update(frame_params)

    match = Match.find(params[:match_id])

    match.update_frames

    league = League.find(params[:league_id])

    league.update_tables(match.player_1)
    league.update_tables(match.player_2)

    league.update_positions

    render :json => match.to_json(:only => [:player_1_frames, :player_2_frames])
  end

  private
    def frame_params
      params.require(:frame).permit(:id, :player_1_points, :player_2_points)
    end


end
