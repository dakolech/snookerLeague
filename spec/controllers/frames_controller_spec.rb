require 'rails_helper'

RSpec.describe FramesController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)
  frame_attr = FactoryGirl.attributes_for(:frame)

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
  end

  describe "PATCH update" do

    describe 'with valid params' do
      it 'updates a match date' do
        patch :update, format: :json, :id => @frame.id, :match_id => @match.id, :frame => frame_attr
        expect(Frame.find(@frame.id).player_1_points).to eq(frame_attr[:player_1_points])
        expect(Frame.find(@frame.id).player_2_points).to eq(frame_attr[:player_2_points])
      end

      it 'returns a updated match' do
        patch :update, format: :json, :id => @frame.id, :match_id => @match.id, :frame => frame_attr
        expect(json['player_1_frames']).to eq(0)
        expect(json['player_2_frames']).to eq(1)
      end

      it 'returns a updated frame' do
        patch :update, format: :json, :id => @frame.id, :match_id => @match.id, :frame => frame_attr
        expect(json['frame']['player_1_points']).to eq(frame_attr[:player_1_points])
        expect(json['frame']['player_2_points']).to eq(frame_attr[:player_2_points])
      end
    end
  end
end
