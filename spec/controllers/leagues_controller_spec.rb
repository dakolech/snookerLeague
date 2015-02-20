require 'rails_helper'

RSpec.describe LeaguesController, :type => :controller do
  let(:json) { JSON.parse(response.body) }

  attr = FactoryGirl.attributes_for(:league, :my_string)
  attr2 = FactoryGirl.attributes_for(:league, :second_league)

  describe "GET index.json" do
    before do
      5.times do
        League.create! attr
      end
      get :index, format: :json
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of leagues" do
      expect(json['leagues'].length).to eq(5)
    end
  end

  describe "GET index.json with search_query" do
    before do
      5.times do
        League.create! attr
      end
      2.times do
        League.create! attr2
      end
      get :index, format: :json, :search_query => "sec"
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "return list of leagues" do
      expect(json['leagues'].length).to eq(2)
    end
  end

  describe "GET show.json" do
    before do
      @league = League.create! attr
      get :show, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "have correct name" do
      expect(json['league']['name']).to eq(@league.name.titleize)
    end
  end


  describe "GET edit.json" do
    before do
      @league = League.create! attr
      get :edit, format: :json, :id => @league.id
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end

end
