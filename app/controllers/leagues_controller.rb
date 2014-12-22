class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(player_params)

    if @league.save
      redirect_to @league, notice: 'League was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])

    if @league.update(player_params)
      redirect_to @league, notice: 'League was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @league = League.find(params[:id])
    if @league.destroy
      redirect_to leagues_index_url, notice: 'League was successfully destroyed.'
    else
      redirect_to leagues_index_url
    end
  end

  def add_player
  end
end
