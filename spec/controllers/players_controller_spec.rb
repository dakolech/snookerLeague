require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  player = FactoryGirl.create(:player)

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, { :id => player.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, { :id => player.id }
      expect(response).to have_http_status(:success)
    end
  end

end
