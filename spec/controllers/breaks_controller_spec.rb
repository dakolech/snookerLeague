require 'rails_helper'

RSpec.describe BreaksController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)
  break_atrr = FactoryGirl.attributes_for(:break, :create)
  break_atrr2 = FactoryGirl.attributes_for(:break, :update)

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
    @frame = @match.frames.first
    break_atrr[:frame_id] = @frame.id
    break_atrr[:player_id] = @match.player_1.id
  end

  describe "POST create" do
    describe 'with valid params' do
      it 'creates a new break' do
        expect {
          post :create, format: :json, :match_id => @match.id, :frame_id => @frame.id, :break => break_atrr
        }.to change(Break, :count).by(1)
      end

      it 'returns a created break' do
        post :create, format: :json, :match_id => @match.id, :frame_id => @frame.id, :break => break_atrr
        expect(json['points']).to eq(0)
        expect(json['player_id']).to eq(break_atrr[:player_id])
      end
    end

    describe 'with invalid params' do
      it 'not creates a new league' do
        expect {
          post :create, format: :json, :match_id => @match.id, :frame_id => @frame.id, :break => break_atrr2
        }.to_not change(Break, :count)
      end
    end
  end

  describe "PATCH update" do
    before do
      @break = Break.create! break_atrr
      patch :update, format: :json, :match_id => @match.id, :frame_id => @frame.id, :id => @break.id, :break => break_atrr2
    end

    describe 'with valid params' do
      it 'updates a break' do
        expect(Break.find(@break.id).points).to eq(break_atrr2[:points])
      end

      it 'returns a updated break' do
        expect(json['points']).to eq(break_atrr2[:points])
      end
    end
  end

  describe "DELETE" do
    before do
      @break = Break.create! break_atrr
    end

    describe 'with valid params' do
      it 'delete a league' do
        expect {
          delete :destroy, format: :json, :match_id => @match.id, :frame_id => @frame.id, :id => @break.id
        }.to change(Break, :count).by(-1)
      end

      it 'returns a deleted league' do
        delete :destroy, format: :json, :match_id => @match.id, :frame_id => @frame.id, :id => @break.id
        expect(json['respond']).to eq('deleted')
      end
    end
  end


end
