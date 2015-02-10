class LeaguesController < ApplicationController
  before_action :find_league, only: [:show, :edit, :update, :destroy, :add_player, :remove_player]
  before_action :find_player, only: [:add_player, :remove_player]

  def index
    @leagues = League.all
  end

  def show
  end

  def create
    @league = League.new(league_params)
    @league.save
  end

  def edit
    if params[:search_query]
      search_query = "%#{params[:search_query]}%".downcase
      @players = Player.where("firstname like ? or lastname like ?", search_query, search_query)
    else
      @players = Player.all
    end

    @players -= @league.players
  end

  def update
    @league.update(league_params)
  end

  def destroy
    @league1 = @league
    @league.destroy
  end

  def add_player
    @league.players << @player

    @league.remove_bye
    @league.add_bye

    @league.update_column :updated_at, Time.now
  end

  def remove_player
    @league.players.delete(@player)

    @league.remove_bye
    @league.add_bye

    @league.update_column :updated_at, Time.now
  end

  private
    def league_params
      params.require(:league).permit(:name, :start_date, :end_date, :number_of_winners, :number_of_dropots, :best_of, :win_points, :loss_points)
    end

    def find_league
      @league = League.find(params[:id])
    end

    def find_player
      @player = Player.find(params[:player_id])
    end

end
