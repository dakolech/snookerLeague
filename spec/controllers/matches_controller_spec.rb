require 'rails_helper'

RSpec.describe MatchesController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)
  match_attr = FactoryGirl.attributes_for(:match)

  before do
    @league = League.create! league_attr
    @player1 = Player.create! player_atrr
    @league.players << @player1
    @player2 = Player.create! player_atrr2
    @league.players << @player2
    @player3 = Player.create! player_atrr3
    @league.players << @player3
    @player4 = Player.create! player_atrr4
    @league.players << @player4
    @league.generate_filled_rounds
    @round = @league.rounds.first
    @match = @round.matches.first
  end

  describe "GET edit.json" do
    before do
      get :edit, format: :json, :id => @match.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "have correct players" do
      expect(json['player_1']['name']).to eq(@match.player_1.full_name)
      expect(json['player_2']['name']).to eq(@match.player_2.full_name)
    end

    it "have correct number of frames" do
      expect(json['frames'].length).to eq(@match.frames.size)
    end
  end

  describe "PATCH update" do

    describe 'with valid params' do
      it 'updates a match date' do
        patch :update, format: :json, :id => @match.id, :match => match_attr
        expect(Match.find(@match.id).date).to eq(match_attr[:date].to_date)
      end

      it 'returns a updated match' do
        patch :update, format: :json, :id => @match.id, :match => match_attr
        expect(json['date']).to eq(match_attr[:date])
      end
    end
  end

  describe "PATCH update_player" do

    describe 'with valid params' do
      it 'updates a player_1' do
        expect(Match.find(@match.id).player_1.id).not_to eq(@player4.id)
        patch :update_player, format: :json, :id => @match.id, :which => 1, :player => @player4.id
        expect(Match.find(@match.id).player_1.id).to eq(@player4.id)
      end

      it 'returns a player_1 id with name' do
        patch :update_player, format: :json, :id => @match.id, :which => 1, :player => @player4.id
        expect(json['id']).to eq(@player4.id)
        expect(json['name']).to eq(@player4.full_name)
      end

      it 'updates a player_2' do
        expect(Match.find(@match.id).player_2.id).not_to eq(@player4.id)
        patch :update_player, format: :json, :id => @match.id, :which => 2, :player => @player4.id
        expect(Match.find(@match.id).player_2.id).to eq(@player4.id)
      end

      it 'returns a player_2 id with name' do
        patch :update_player, format: :json, :id => @match.id, :which => 2, :player => @player4.id
        expect(json['id']).to eq(@player4.id)
        expect(json['name']).to eq(@player4.full_name)
      end
    end
  end



end
