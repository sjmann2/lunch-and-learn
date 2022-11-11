require 'rails_helper'

RSpec.describe 'The recipe request spec' do
  describe 'GET /api/v1/recipes?country=thailand' do
    it 'returns recipes for a given country' do
      get "/api/v1/recipes?country=thailand"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a(Hash)
      expect(recipes[:data]).to be_an(Array)
      expect(recipes[:data]).to have_key(:id)
      expect(recipes[:data]).to have_key(:type)

      recipe = recipes[:data].first

      expect(recipe).to have_key(:attributes)
      expect(recipe[:attributes].count).to eq(4)
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:country]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
    end
  end
end