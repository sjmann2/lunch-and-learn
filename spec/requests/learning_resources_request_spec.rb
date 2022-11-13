require 'rails_helper'

RSpec.describe 'The learning resources request' do
  describe 'GET /api/v1/learning_resources?country=laos' do
    it 'returns learning resources for a given country', :vcr do
      get '/api/v1/learning_resources?country=laos'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      resources = JSON.parse(response.body, symbolize_names: true)

      expect(resources).to be_a(Hash)
      expect(resources[:data]).to have_key(:type)
      expect(resources[:data][:attributes]).to have_key(:country)
      expect(resources[:data][:attributes].count).to eq(3)
      expect(resources[:data][:attributes][:country]).to be_a(String)
      expect(resources[:data][:attributes][:video]).to be_a(Hash)
      expect(resources[:data][:attributes][:video][:title]).to be_a(String)
      expect(resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)
      expect(resources[:data][:attributes][:video]).to_not have_key(:description)
      expect(resources[:data][:attributes][:images]).to be_an(Array)
      expect(resources[:data][:attributes][:images].first[:alt_tag]).to be_a(String)
      expect(resources[:data][:attributes][:images].first[:url]).to be_a(String)
      expect(resources[:data][:attributes][:images].first).to_not have_key(:color)
    end
  end

  describe 'if no images or videos are found for the country', :vcr do
    it 'returns empty arrays' do
      get '/api/v1/learning_resources?country=fjkdsloafjdilfjdskl'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      resources = JSON.parse(response.body, symbolize_names: true)

      expect(resources[:data][:attributes][:country]).to eq('fjkdsloafjdilfjdskl')
      expect(resources[:data][:attributes][:images]).to be_empty
      expect(resources[:data][:attributes][:video]).to be_empty
    end
  end

  describe 'if no video is found for the country' do
    it 'returns a learning resources with an empty video array', :vcr do
      json_response = File.read('spec/fixtures/empty_video.json')
      youtube_api_key = ENV['youtube_api_key']
      stub_request(:get, "https://www.googleapis.com/youtube/v3/search?key=#{youtube_api_key}&part=snippet&type=video&q=uruguay+history")
      .to_return(status: 200, body: json_response)

      get '/api/v1/learning_resources?country=uruguay'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:data][:attributes][:video]).to be_empty
    end
  end

  describe 'if no images are found for the country' do
    it 'returns a learning resource with an empty image array', :vcr do
      json_response = File.read('spec/fixtures/empty_images.json')
      unsplash_client_id = ENV['unsplash_client_id']
      stub_request(:get, "https://api.unsplash.com/search/photos?query=uruguay&client_id=#{unsplash_client_id}")
      .to_return(status: 200, body: json_response)

      get '/api/v1/learning_resources?country=uruguay'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:data][:attributes][:images]).to be_empty
    end
  end
end