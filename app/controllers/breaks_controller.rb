class BreaksController < ApplicationController
  before_action :find_break, only: [:update, :destroy]

  def create
    if break_params[:player_id] && break_params[:frame_id]
      @break = Break.new(break_params)
      @break.points = 0
      @break.save
    end
  end

  def update
    @break.update(break_params)
  end

  def destroy
    @break.destroy
  end

  private
    def break_params
      params.require(:break).permit(:player_id, :frame_id, :points)
    end

    def find_break
      @break = Break.find(params[:id])
    end
end
