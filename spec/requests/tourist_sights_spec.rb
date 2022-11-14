require 'rails_helper'

RSpec.describe 'The tourist sights request' do
  describe 'GET /api/v1/tourist_sights?country=France' do
    it 'returns a collection of all tourist sites within a 20000 meter radius of the capital city', :vcr do
      get '/api/v1/tourist_sights?country=France'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      sites = JSON.parse(response.body, symbolize_names: true)

      expect(sites).to be_a(Hash)
      expect(sites[:data]).to be_an(Array)

      site = sites[:data].first

      expect(site).to have_key(:id)
      expect(site).to have_key(:type)
      expect(site).to have_key(:attributes)
      expect(site[:attributes].count).to eq(3)
      expect(site[:attributes]).to have_key(:name)
      expect(site[:attributes][:name]).to be_a(String)
      expect(site[:attributes]).to have_key(:address)
      expect(site[:attributes][:address]).to be_a(String)
      expect(site[:attributes]).to have_key(:place_id)
      expect(site[:attributes][:place_id]).to be_a(String)
    end
  end
end