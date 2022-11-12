require 'rails_helper'

RSpec.describe 'The favorite request' do
  describe 'POST /api/v1/favorites' do
    describe 'When api key is valid' do
      it 'creates a favorite recipe for the given user' do
        user = User.create!(name: "Tina", email: "linagirl@yahoo.com", api_key: 'jgn983hy48thw9begh98h4539h4')

        headers = {'CONTENT_TYPE' => 'application/json'}
        body = JSON.generate(
          api_key: "jgn983hy48thw9begh98h4539h4",
          country: "thailand",
          recipe_link: "https://www.tastingtable.com", 
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)")

        post '/api/v1/favorites', headers: headers, params: body

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:success)
        expect(result[:success]).to eq("Favorite added successfully")
      end
    end

    describe 'When the api key does not match any user' do
      it 'returns a 400 status and error message' do
        user = User.create!(name: "Tina", email: "linagirl@yahoo.com", api_key: 'jgn983hy48thw9begh98h4539h4')
        
        headers = {'CONTENT_TYPE' => 'application/json'}
        body = JSON.generate(
          api_key: "knm483hy48thw9begh98h4539h7",
          country: "thailand",
          recipe_link: "https://www.tastingtable.com", 
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)")

        post '/api/v1/favorites', headers: headers, params: body

        expect(response).to have_http_status(404)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:errors].first[:message]).to eq("No user found with api_key knm483hy48thw9begh98h4539h7")
      end
    end
  end
end
# 
# Content-Type: application/json
# Accept: application/json

# {
#     "api_key": "jgn983hy48thw9begh98h4539h4",
#     "country": "thailand",
#     "recipe_link": "https://www.tastingtable.com/.....",
#     "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
# }
# Response:

# {
#     "success": "Favorite added successfully"
# }