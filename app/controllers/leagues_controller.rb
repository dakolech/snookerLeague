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
      redirect_to action: 'edit', id: params[:id]
    else
      render action: 'new'
    end
  end

  def edit
    @league = League.find(params[:id])

  end

  def edit_angular
    @league = League.find(params[:id])

    @players = Player.all

    @players -= @league.players

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

    remove_bye(@league)
    add_bye(@league)

    @league.update_column :updated_at, Time.now

    render :json => @league.players.to_json(:only => [ :id, :firstname, :lastname, :max_break, :email ])
  end

  def remove_player
    @league = League.find(params[:id])
    @player = Player.find(params[:player_id])

    @league.players.delete(@player)

    remove_bye(@league)
    add_bye(@league)

    @league.update_column :updated_at, Time.now

    render :json => @league.players.to_json(:only => [ :id, :firstname, :lastname, :max_break, :email ])
  end

  private
    def league_params
      params.require(:league).permit(:name, :start_date, :end_date, :number_of_winners, :number_of_dropots, :best_of, :win_points, :loss_points)
    end

    def add_bye(league)
      if league.players.size%2 == 1
        bye = Player.create!(firstname:     "Bye",
                             date_of_birth: league.start_date,
                             phone_number:  0,
                             max_break:     0)
        league.players << bye
      end
    end
  def remove_bye(league)
    if league.players.size%2 == 1
      league.players.where(:firstname => "Bye").destroy_all
    end
    Player.where(:firstname => "Bye").destroy_all
  end
end
