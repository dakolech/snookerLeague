class PlayersController < ApplicationController
  def index
  end

  def index_angular
    if params[:search_query]
      search_query = "%#{params[:search_query]}%"
      @players = Player.where("firstname like ? or lastname like ?", search_query, search_query)
    else
      @players = Player.all
    end

    #@players = Player.all
    @players.where(:firstname => "Bye").destroy_all
  end

  def show
    @player = Player.find(params[:id])
  end

  def show_angular
    @player = Player.find(params[:player_id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    @player.firstname = @player.firstname.capitalize
    @player.lastname = @player.lastname.capitalize
    @player.email = @player.email.downcase

    @player.save

    render :json => @player.to_json(:only => [:id, :firstname, :lastname, :email, :max_break])
  end

  def edit
    @player = Player.find(params[:id])

  end

  def update
    @player = Player.find(params[:id])

    @player.firstname = @player.firstname.capitalize
    @player.lastname = @player.lastname.capitalize
    @player.email = @player.email.downcase

    @player.update(player_params)

    render :json => @player.to_json(:only => [:id, :firstname, :lastname, :email, :max_break])
  end

  def destroy
    @player = Player.find(params[:id])
    @player1 = @player
    @player.destroy

    render :json => @player1.to_json(:only => [:id])

  end

  private
    def player_params
      params.require(:player).permit(:firstname, :lastname, :email, :phone_number, :max_break, :date_of_birth, :city)
    end
end
