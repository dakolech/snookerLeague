require 'rails_helper'

RSpec.describe RoundsController, :type => :controller do
  round = FactoryGirl.create(:round)
  league = FactoryGirl.create(:league)

  describe "GET index" do
    it "returns http success" do
      get :index, {:league_id => league}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {:league_id => league, :id => round}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {:league_id => league, :id => round}
      expect(response).to have_http_status(:success)
    end
  end

end
