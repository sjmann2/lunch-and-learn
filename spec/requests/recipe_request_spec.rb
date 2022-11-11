require 'rails_helper'

RSpec.describe 'The recipe request spec' do
  describe 'Given a country search term' do
    describe 'GET /api/v1/recipes?country=thailand' do
      it 'returns recipes for a given country', :vcr do
        get "/api/v1/recipes?country=thailand"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(recipes).to be_a(Hash)
        expect(recipes[:data]).to be_an(Array)
        
        recipe = recipes[:data].first
        
        expect(recipe).to have_key(:id)
        expect(recipe).to have_key(:type)
        expect(recipe).to have_key(:attributes)
        expect(recipe[:attributes].count).to eq(4)
        expect(recipe[:attributes][:title]).to be_a(String)
        expect(recipe[:attributes][:url]).to be_a(String)
        expect(recipe[:attributes][:country]).to be_a(String)
        expect(recipe[:attributes][:image]).to be_a(String)
        expect(recipe[:attributes]).to_not have_key(:ingredients)
        expect(recipe[:attributes]).to_not have_key(:calories)
      end
    end
  end

  describe "Given an empty string" do
    it 'returns an empty array', :vcr do
      get "/api/v1/recipes?country="

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes[:data]).to be_empty
    end
  end

  describe "Given no country search term" do
    it 'returns recipes for a random country', :vcr do
      json_country_response = File.read('spec/fixtures/random_country.json')
      stub_request(:get, "https://restcountries.com/v2/all").to_return(status: 200, body: json_country_response)

      get "/api/v1/recipes"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a(Hash)
      expect(recipes[:data]).to be_an(Array)
      
      recipe = recipes[:data].first
      
      expect(recipe).to have_key(:id)
      expect(recipe).to have_key(:type)
      expect(recipe).to have_key(:attributes)
      expect(recipe[:attributes].count).to eq(4)
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:country]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
      expect(recipe[:attributes]).to_not have_key(:ingredients)
      expect(recipe[:attributes]).to_not have_key(:calories)
    end
  end
end
