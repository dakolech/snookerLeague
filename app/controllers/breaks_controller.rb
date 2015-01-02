class BreaksController < ApplicationController
  def index
  end

  def create
    @break = Break.new(break_params)

    @break.points = 0

    @break.save

    render :json => @break.to_json(:only => [:points, :id, :player_id])
  end

  def new
  end

  def edit
  end

  def update
    @break = Break.find(params[:id])

    @break.update(break_params)

    @respond = 'succes'

    render :json => @respond.to_json
  end

  def destroy
    @break = Break.find(params[:id])

    @break.destroy

    render :json => @break.to_json(:only => [:points, :id, :player_id])
  end

  private
    def break_params
      params.require(:break).permit(:player_id, :frame_id, :match_id, :points)
    end
end
