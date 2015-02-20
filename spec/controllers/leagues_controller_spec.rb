require 'rails_helper'

RSpec.describe LeaguesController, :type => :controller do
  league = FactoryGirl.create(:league)

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
      get :show, format: :json, :id => league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end


  describe "GET edit.json" do
    before do
      get :edit, format: :json, :id => league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end

end
