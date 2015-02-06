class StaticPagesController < ApplicationController

  def home
  end

  def statistics
    @players = Player.all.size
    @leagues = League.all.size
    @rounds = Round.all.size
    @matches = Match.all.size
    @frames = Frame.all.size
    @breaks = Break.all.size
    #@h_break = Break.all.find_by 'points': Break.maximum("points")
    @h_breaks = Break.all.reorder(points: :desc).limit(5)
  end
end
