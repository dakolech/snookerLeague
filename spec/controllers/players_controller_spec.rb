require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  let(:player_invalid) { { lastname: 'asd'} }

  describe "GET index.json" do
    before do
      5.times do
        Player.create! player_atrr
      end
      get :index, format: :json
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of players" do
      expect(json['players'].length).to eq(5)
    end
  end

  describe "GET index.json with search_query" do
    before do
      5.times do
        Player.create! player_atrr
      end
      2.times do
        Player.create! player_atrr2
      end
      get :index, format: :json, :search_query => "sec"
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of players" do
      expect(json['players'].length).to eq(2)
    end
  end

  describe "GET show.json" do
    before do
      @player = Player.create! player_atrr
      get :show, format: :json, :id => @player.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "have correct name" do
      expect(json['firstname']).to eq(@player.firstname.capitalize)
    end
  end

  describe "POST create" do
    describe 'with valid params' do
      it 'creates a new player' do
        expect {
          post :create, format: :json, :player => player_atrr
        }.to change(Player, :count).by(1)
      end

      it 'returns a created player' do
        post :create, format: :json, :player => player_atrr
        expect(json['firstname']).to eq(player_atrr[:firstname])
      end
    end

    describe 'with invalid params' do
      it 'not creates a new player' do
        expect {
          post :create, format: :json, :player => player_invalid
        }.to_not change(Player, :count)
      end
    end
  end

  describe "PATCH update" do
    before do
      @player = Player.create! player_atrr
      patch :update, format: :json, :id => @player.id, :player => player_atrr2
    end

    describe 'with valid params' do
      it 'updates a player' do
        expect(Player.find(@player.id).firstname.capitalize).to eq(player_atrr2[:firstname])
      end

      it 'returns a updated player' do
        expect(json['firstname']).to eq(player_atrr2[:firstname])
      end
    end
  end

  describe "DELETE" do
    before do
      @player = Player.create! player_atrr
    end

    describe 'with valid params' do
      it 'delete a player' do
        expect {
          delete :destroy, format: :json, :id => @player.id
        }.to change(Player, :count).by(-1)
      end

      it 'returns a deleted player' do
        delete :destroy, format: :json, :id => @player.id
        expect(json['id']).to eq(@player.id)
      end
    end
  end

end
