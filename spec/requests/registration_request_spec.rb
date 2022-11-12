require 'rails_helper'

RSpec.describe 'The user registration request' do
  describe 'POST /api/v1/users' do
    describe 'when all params are present' do
      it 'creates a new user and generates a unique api key for them' do
        headers = {"CONTENT_TYPE" => "application/json"}
        body = JSON.generate(name: "Athena Dao", email: "athenadao@bestgirlever.com")
        
        post '/api/v1/users', headers: headers, params: body

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to be_a(String)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:attributes].count).to eq(3)
        expect(result[:data][:attributes][:name]).to be_a(String)
        expect(result[:data][:attributes][:email]).to be_a(String)
        expect(result[:data][:attributes][:api_key]).to be_a(String)

        # {
        #   "data": {
        #     "type": "user",
        #     "id": "1",
        #     "attributes": {
        #       "name": "Athena Dao",
        #       "email": "athenadao@bestgirlever.com",
        #       "api_key": "jgn983hy48thw9begh98h4539h4"
        #     }
        #   }
        # }

      end
    end
  end
end