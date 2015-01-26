class StaticPagesController < ApplicationController

  def statistics

  end

  def statistics_angular
    @leagues = League.all.size
  end
end
