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
    @league = League.new(league_params)

    if @league.save
      redirect_to @league, notice: 'League was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @league = League.find(params[:id])
    @players = Player.joins("LEFT OUTER JOIN leagues_players ON leagues_players.player_id = players.id
                             LEFT OUTER JOIN leagues ON leagues.id = leagues_players.league_id")
                            .where("leagues.id != ? or leagues.id is null", @league.id)
    @league_players = @league.players
  end

  def update
    @league = League.find(params[:id])

    if @league.update(league_params)
      redirect_to action: 'edit', id: params[:id]
    else
      redirect_to action: 'edit', id: params[:id]
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
    @league = League.find(params[:id])
    @player = Player.find(params[:player_id])

    @league.players << @player

    redirect_to action: 'edit', id: params[:id]
  end

  def remove_player
    @league = League.find(params[:id])
    @player = Player.find(params[:player_id])

    @league.players.delete(@player)

    redirect_to action: 'edit', id: params[:id]
  end

  private
    def league_params
      params.require(:league).permit(:name, :start_date, :end_date, :number_of_winners, :number_of_dropots, :best_of, :win_points, :loss_points)
    end
end
