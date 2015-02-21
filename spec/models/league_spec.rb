require 'rails_helper'

RSpec.describe League, :type => :model do
  league_attr = FactoryGirl.attributes_for(:league, :my_string)
  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :second)
  player_atrr3 = FactoryGirl.attributes_for(:player, :third)
  player_atrr4 = FactoryGirl.attributes_for(:player, :fourth)

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :number_of_winners }
    it { should validate_presence_of :number_of_dropots }
    it { should validate_presence_of :best_of }
    it { should validate_presence_of :win_points }
    it { should validate_presence_of :loss_points }
  end

  before do
    @league = League.create! league_attr
    @player1 = Player.create! player_atrr
    @league.players << @player1
    @player2 = Player.create! player_atrr2
    @league.players << @player2
    @player3 = Player.create! player_atrr3
    @player4 = Player.create! player_atrr4
  end

  describe "add_bye" do
    it "should add bye" do
      @league.players << @player3
      @league.add_bye
      expect(@league.players.size).to eq(4)
    end

    it "should not add bye" do
      @league.players << @player3
      @league.players << @player4
      @league.add_bye
      expect(@league.players.size).to eq(4)
    end
  end

  describe "remove_bye" do
    it "should remove bye" do
      @league.players << @player3
      @league.add_bye
      @league.players << @player4
      @league.remove_bye
      expect(@league.players.size).to eq(4)
    end

    it "should not remove bye" do
      @league.players << @player3
      @league.add_bye
      @league.remove_bye
      expect(@league.players.size).to eq(4)
    end
  end
end
