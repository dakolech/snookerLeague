require 'rails_helper'

RSpec.describe Player, :type => :model do

  player_atrr = FactoryGirl.attributes_for(:player, :first)
  player_atrr2 = FactoryGirl.attributes_for(:player, :without_lastname)

  describe 'validations' do
    it { should validate_presence_of :firstname }
    it { should validate_presence_of :date_of_birth }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :max_break }
  end

  describe "full_name" do
    before do
      @player = Player.create! player_atrr
      @player2 = Player.create! player_atrr2
    end

    it "returns a full name as a string" do
      expect(@player.full_name).to eq("#{player_atrr[:firstname].capitalize} #{player_atrr[:lastname].capitalize}")
    end

    it "returns a firstname as a string" do
      expect(@player2.full_name).to eq("#{player_atrr2[:firstname].capitalize}")
    end
  end
end
