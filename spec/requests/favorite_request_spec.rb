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
        expect(result[:errors].first[:message]).to eq("Could not find user with api_key knm483hy48thw9begh98h4539h7")
      end
    end
  end

  describe 'GET /api/v1/favorites' do
    describe 'When the api key is valid' do
      it 'returns a list of that users favorites' do
        user = User.create!(name: "Tina", email: "linagirl@yahoo.com", api_key: 'jgn983hy48thw9begh98h4539h4')
        favorite = user.favorites.create!(country: "thailand",  recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", recipe_link: "https://www.tastingtable.com")
        favorite = user.favorites.create!(country: "egypt",  recipe_title: "Recipe: Egyptian Tomato Soup", recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....")
        
        headers = {'CONTENT_TYPE' => 'application/json'}
        body = JSON.generate(
          api_key: "jgn983hy48thw9begh98h4539h4")

        get '/api/v1/favorites', headers: headers, params: JSON.parse(body)

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        results = JSON.parse(response.body, symbolize_names: true)

        expect(results[:data][0]).to have_key(:id)
        expect(results[:data][0]).to have_key(:type)
        expect(results[:data][0]).to have_key(:attributes)
        expect(results[:data][0][:attributes][:recipe_title]).to be_a(String)
        expect(results[:data][0][:attributes][:recipe_link]).to be_a(String)
        expect(results[:data][0][:attributes][:country]).to be_a(String)
        expect(results[:data][0][:attributes][:created_at]).to be_a(String)
      end

      describe 'when the user has not favorited any recipes' do
        it 'returns a data object with an empty array' do
          user = User.create!(name: "Tina", email: "linagirl@yahoo.com", api_key: 'jgn983hy48thw9begh98h4539h4')

          headers = {'CONTENT_TYPE' => 'application/json'}
          body = JSON.generate(
            api_key: "jgn983hy48thw9begh98h4539h4")
  
          get '/api/v1/favorites', headers: headers, params: JSON.parse(body)

          expect(response).to be_successful
          expect(response).to have_http_status(200)

          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:data]).to be_empty
        end
      end
    end

    describe 'When the api key does not match any user' do
      it 'returns a status 404 and error message' do
        headers = {'CONTENT_TYPE' => 'application/json'}
        body = JSON.generate(
          api_key: "jgn983hy48thw9begh98h4539h4")

        get '/api/v1/favorites', headers: headers, params: JSON.parse(body)

        expect(response).to have_http_status(404)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:errors].first[:message]).to eq("Could not find user with api_key jgn983hy48thw9begh98h4539h4")
      end
    end
  end
end
# 
# Content-Type: application/json
# Accept: application/json

# {
#     "api_key": "jgn983hy48thw9begh98h4539h4"
# }

# {
#   "data": [
#       {
#           "id": "1",
#           "type": "favorite",
#           "attributes": {
#               "recipe_title": "Recipe: Egyptian Tomato Soup",
#               "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
#               "country": "egypt",
#               "created_at": "2022-11-02T02:17:54.111Z"
#           }
#       },
#       {
#           "id": "2",
#           "type": "favorite",
#           "attributes": {
#               "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
#               "recipe_link": "https://www.tastingtable.com/.....",
#               "country": "thailand",
#               "created_at": "2022-11-07T03:44:08.917Z"
#           }
#       }
#   ]
# }    