class PlayersController < ApplicationController
  before_action :find_player, only: [:show, :update, :destroy]

  def index
    if params[:search_query]
      search_query = "%#{params[:search_query]}%".downcase
      @players = Player.where("firstname like ? or lastname like ?", search_query, search_query)
    else
      @players = Player.all
    end

    @players.where(:firstname => "Bye").destroy_all
  end

  def show
  end

  def create
    @player = Player.new(player_params)
    @player.save
  end


  def update
    @player.update(player_params)
  end

  def destroy
    @player1 = @player
    @player.destroy
  end

  private
    def player_params
      params.require(:player).permit(:firstname, :lastname, :email, :phone_number, :max_break, :date_of_birth, :city)
    end

    def find_player
      @player = Player.find(params[:id])
    end
end
