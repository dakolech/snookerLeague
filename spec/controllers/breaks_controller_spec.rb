require 'rails_helper'

RSpec.describe BreaksController, :type => :controller do
  break1 = FactoryGirl.create(:break)
  match = FactoryGirl.create(:match)
  round = FactoryGirl.create(:round)
  league = FactoryGirl.create(:league)

  describe "GET index" do
    it "returns http success" do
      get :index, {:league_id => league, :round_id => round, :match_id => match}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, {:league_id => league, :round_id => round, :match_id => match}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do

    it "returns http success" do
      get :edit, {:id => break1.id, :league_id => league, :round_id => round, :match_id => match}
      expect(response).to have_http_status(:success)
    end
  end

end
