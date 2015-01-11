class LeaguesController < ApplicationController
  def index

  end

  def index_angular
    @leagues = League.all

  end

  def show
    @league = League.find(params[:id])
  end


  def show_angular
    @league = League.find(params[:id])
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)

    @league.save

    render :json => @league.to_json(:only => [:id, :name, :start_date, :end_date, :best_of])
  end

  def edit
    @league = League.find(params[:id])

  end

  def edit_angular
    @league = League.find(params[:id])

    if params[:search_query]
      search_query = "%#{params[:search_query]}%"
      @players = Player.where("firstname like ? or lastname like ?", search_query, search_query)
    else
      @players = Player.all
    end

    @players -= @league.players

  end

  def update
    @league = League.find(params[:id])

    @league.update(league_params)

    render :json => @league.to_json(:only => [:id, :name, :start_date, :end_date, :best_of])
  end

  def destroy
    @league = League.find(params[:id])
    @league1 = @league
    @league.destroy

      render :json => @league.to_json(:only => [:id])
  end

  def add_player
    @league = League.find(params[:id])
    @player = Player.find(params[:player_id])

    @league.players << @player

    @league.remove_bye
    @league.add_bye

    @league.update_column :updated_at, Time.now

    render :json => @league.players.to_json(:only => [ :id, :firstname, :lastname, :max_break, :email ])
  end

  def remove_player
    @league = League.find(params[:id])
    @player = Player.find(params[:player_id])

    @league.players.delete(@player)

    @league.remove_bye
    @league.add_bye

    @league.update_column :updated_at, Time.now

    render :json => @league.players.to_json(:only => [ :id, :firstname, :lastname, :max_break, :email ])
  end

  private
    def league_params
      params.require(:league).permit(:name, :start_date, :end_date, :number_of_winners, :number_of_dropots, :best_of, :win_points, :loss_points)
    end

end
