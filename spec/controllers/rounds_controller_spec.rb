require 'rails_helper'

RSpec.describe RoundsController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)
  round_attr = FactoryGirl.attributes_for(:round, :start_date)

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
  end

  describe "GET edit_all.json" do
    before do
      @league.generate_empty_rounds
      get :edit_all, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of rounds" do
      expect(json['league']['rounds'].length).to eq(3)
    end
  end

  describe "PATCH update" do
    before do
      @league.generate_empty_rounds
      @round = @league.rounds.first
      patch :update, format: :json, :id => @round.id, :league_id => @league.id, :round => round_attr
    end

    describe 'with valid params' do
      it 'updates a round date' do
        expect(Round.find(@round.id).start_date).to eq(round_attr[:start_date].to_date)
      end

      it 'returns a updated round' do
        expect(json['start_date']).to eq(round_attr[:start_date])
      end
    end
  end

  describe "GET generate_empty.json" do
    before do
      get :generate_empty, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of empty rounds" do
      expect(json['league']['rounds'][1]['matches'][1]['player_1']).to eq(nil)
      expect(json['league']['rounds'].length).to eq(3)
    end
  end

  describe "GET generate_filled.json" do
    before do
      get :generate_filled, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of filled rounds" do
      expect(json['league']['rounds'][1]['matches'][1]['player_1']).to_not eq(nil)
      expect(json['league']['rounds'].length).to eq(3)
    end
  end



end
