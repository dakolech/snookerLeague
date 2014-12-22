require 'rails_helper'

RSpec.describe MatchesController, :type => :controller do
  match = FactoryGirl.create(:match)
  round = FactoryGirl.create(:round)
  league = FactoryGirl.create(:league)

  describe "GET show" do
    it "returns http success" do
      get :show, {:league_id => league, :round_id => round, :id => match}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {:league_id => league, :round_id => round, :id => match}
      expect(response).to have_http_status(:success)
    end
  end

end
