require 'rails_helper'

RSpec.describe 'The learning resources request' do
  describe 'GET /api/v1/learning_resources?country=laos' do
    it 'returns learning resources for a given country' do
      get '/api/v1/learning_resources?country=laos'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      resources = JSON.parse(response.body, symbolize_names: true)

      expect(resources).to be_a(Hash)
      expect(resources[:data]).to have_key(:type)
      expect(resources[:data][:attributes]).to have_key(:country)
      expect(resources[:data][:attributes][:country]).to be_a(String)
      expect(resources[:data][:attributes][:video]).to be_a(Hash)
      expect(resources[:data][:attributes][:video][:title]).to be_a(String)
      expect(resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)
      expect(resources[:data][:attributes][:images]).to be_an(Array)
      expect(resources[:data][:attributes][:images].first[:alt_tag]).to be_a(String)
      expect(resources[:data][:attributes][:images].first[:url]).to be_a(String)
    end
  end
end