require 'rails_helper'

RSpec.describe LeaguesController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  league_attr2 = FactoryGirl.attributes_for(:league, :second_league)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)
  let(:league_invalid) { { name: 'asd'} }

  describe "GET index.json" do
    before do
      5.times do
        League.create! league_attr
      end
      get :index, format: :json
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of leagues" do
      expect(json['leagues'].length).to eq(5)
    end
  end

  describe "GET index.json with search_query" do
    before do
      5.times do
        League.create! league_attr
      end
      2.times do
        League.create! league_attr2
      end
      get :index, format: :json, :search_query => "sec"
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of leagues" do
      expect(json['leagues'].length).to eq(2)
    end
  end

  describe "GET show.json" do
    before do
      @league = League.create! league_attr
      get :show, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "have correct name" do
      expect(json['league']['name']).to eq(@league.name.titleize)
    end
  end


  describe "GET edit.json" do
    before do
      @league = League.create! league_attr
      Player.create! player_atrr
      Player.create! player_atrr2
      @player1 = Player.create! player_atrr3
      @league.players << @player1
      @player2 = Player.create! player_atrr4
      @league.players << @player2
      get :edit, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of players not in league" do
      expect(json['players'].length).to eq(2)
    end

    it "return list of players in league" do
      expect(json['league_players'].length).to eq(2)
    end

    it "have correct name" do
      expect(json['league']['name']).to eq(@league.name.titleize)
    end
  end

  describe "GET edit.json with search_query" do
    before do
      @league = League.create! league_attr
      5.times do
        Player.create! player_atrr
      end
      2.times do
        Player.create! player_atrr2
      end
      get :edit, format: :json, :id => @league.id, :search_query => "sec"
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of players" do
      expect(json['players'].length).to eq(2)
    end
  end

  describe "POST create" do
    describe 'with valid params' do
      it 'creates a new league' do
        expect {
          post :create, format: :json, :league => league_attr
        }.to change(League, :count).by(1)
      end

      it 'returns a created league' do
        post :create, format: :json, :league => league_attr
        expect(json['name']).to eq(league_attr[:name])
      end
    end

    describe 'with invalid params' do
      it 'not creates a new league' do
        expect {
          post :create, format: :json, :league => league_invalid
        }.to_not change(League, :count)
      end
    end
  end

  describe "PATCH update" do
    before do
      @league = League.create! league_attr
    end

    describe 'with valid params' do
      it 'updates a league' do
        patch :update, format: :json, :id => @league.id, :league => league_attr2
        expect(League.find(@league.id).name.titleize).to eq(league_attr2[:name])
      end

      it 'returns a updated league' do
        patch :update, format: :json, :id => @league.id, :league => league_attr2
        expect(json['name']).to eq(league_attr2[:name])
      end
    end
  end

  describe "DELETE" do
    before do
      @league = League.create! league_attr
    end

    describe 'with valid params' do
      it 'delete a league' do
        expect {
          delete :destroy, format: :json, :id => @league.id
        }.to change(League, :count).by(-1)
      end

      it 'returns a deleted league' do
        delete :destroy, format: :json, :id => @league.id
        expect(json['id']).to eq(@league.id)
      end
    end
  end

  describe "GET add_player" do
    before do
      @league = League.create! league_attr
      @player = Player.create! player_atrr
      @player1 = Player.create! player_atrr3
      @league.players << @player1
    end
    describe 'with valid params' do
      it 'add player to league' do
        expect {
          get :add_player, format: :json, :id => @league.id, :player_id => @player.id
        }.to change(@league.players, :count).by(1)
      end

      it 'returns a players in league' do
        get :add_player, format: :json, :id => @league.id, :player_id => @player.id
        expect(json['players'].length).to eq(2)
      end
    end
  end

  describe "GET remove_player" do
    before do
      @league = League.create! league_attr
      @player = Player.create! player_atrr3
      @league.players << @player
      @player = Player.create! player_atrr2
      @league.players << @player
      @player = Player.create! player_atrr4
      @league.players << @player
    end
    describe 'with valid params' do
      it 'remove player from league' do
        expect {
          get :remove_player, format: :json, :id => @league.id, :player_id => @player.id
        }.to change(@league.players, :count).by(-1)
      end

      it 'returns a players in league' do
        get :remove_player, format: :json, :id => @league.id, :player_id => @player.id
        expect(json['players'].length).to eq(2)
      end
    end
  end

end
