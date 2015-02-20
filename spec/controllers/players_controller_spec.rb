require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  player = FactoryGirl.create(:player)

  describe "GET index.json" do
    before do
      get :index, format: :json
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end



  describe "GET show.json" do
    before do
      get :show, format: :json, :id => player.id
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end

end
