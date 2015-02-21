require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  describe "GET home" do
    before do
      get :home
    end

    it "returns http success" do
      expect(response).to be_success
    end

  end

  describe "GET statistics.json" do
    before do
      get :statistics, format: :json
    end

    it "returns http success" do
      expect(response).to be_success
    end

  end

end
