class BreaksController < ApplicationController
  before_action :find_break, only: [:update, :destroy]

  def create
    @break = Break.new(break_params)
    @break.points = 0
    @break.save
  end

  def update
    @break.update(break_params)
  end

  def destroy
    @break.destroy
  end

  private
    def break_params
      params.require(:break).permit(:player_id, :frame_id, :match_id, :points)
    end

    def find_break
      @break = Break.find(params[:id])
    end
end
