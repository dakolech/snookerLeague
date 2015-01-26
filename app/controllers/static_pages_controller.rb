class StaticPagesController < ApplicationController

  def statistics

  end

  def statistics_angular
    @players = Player.all.size
    @leagues = League.all.size
    @rounds = Round.all.size
    @matches = Match.all.size
    @frames = Frame.all.size
    @breaks = Break.all.size

  end
end
