require 'rails_helper'

RSpec.describe 'The tourist sights request' do
  describe 'GET /api/v1/tourist_sights?country=France' do
    describe 'When the country has tourist sites within a 20000 meter radius of the capital' do
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
        expect(site[:attributes]).to_not include(:categories)
      end

      it 'returns a collection of all tourist sites for countries with 2 word names', :vcr do
        get '/api/v1/tourist_sights?country=new zealand'

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

    describe 'When the country does not have tourist sites within a 20000 meter radius of the capital' do
      it 'returns a response with an empty body', :vcr do
        get '/api/v1/tourist_sights?country=Ecuador'

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        sites = JSON.parse(response.body, symbolize_names: true)
        expect(sites[:data]).to be_empty
      end
    end
  end

  describe 'GET /api/v1/tourist_sights' do
    it 'gives back a sights for a random country if one is not passed in', :vcr do
      json_response = File.read('spec/fixtures/random_country.json')
      stub_request(:get, "https://restcountries.com/v2/all").to_return(status: 200, body: json_response)
      get '/api/v1/tourist_sights'

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