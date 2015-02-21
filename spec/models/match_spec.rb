require 'rails_helper'

RSpec.describe Match, :type => :model do

  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)

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
    @frame2 = @match.frames.second
  end

  describe "update_frames" do
    describe "player_1 win 2 frames" do
      before do
        @frame.player_1_points = 100
        @frame.player_2_points = 50
        @frame2.player_1_points = 100
        @frame2.player_2_points = 50
        @frame.save
        @frame2.save
        @match.update_frames
      end

      it "should update players frames" do
        expect(Match.find(@match.id).player_1_frames).to eq(2)
        expect(Match.find(@match.id).player_2_frames).to eq(0)
      end
    end

    describe "player_2 win 2 frames" do
      before do
        @frame.player_1_points = 50
        @frame.player_2_points = 100
        @frame2.player_1_points = 50
        @frame2.player_2_points = 100
        @frame.save
        @frame2.save
        @match.update_frames
      end

      it "should update players frames" do
        expect(Match.find(@match.id).player_1_frames).to eq(0)
        expect(Match.find(@match.id).player_2_frames).to eq(2)
      end
    end

  end

end
