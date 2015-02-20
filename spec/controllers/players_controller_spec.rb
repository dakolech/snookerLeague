require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  player_attr = FactoryGirl.attributes_for(:player, :first)

  describe "GET index.json" do
    before do
      5.times do
        Player.create! player_attr
      end
      get :index, format: :json
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end



  describe "GET show.json" do
    before do
      @player = Player.create! player_attr
      get :show, format: :json, :id => @player.id
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end

end
