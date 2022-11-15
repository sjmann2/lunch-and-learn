require 'rails_helper'

RSpec.describe 'The user registration/login request' do
  let!(:headers) {{"CONTENT_TYPE" => "application/json"}}
  describe 'POST /api/v1/users' do
    describe 'when all params are present' do
      it 'creates a new user and generates a unique api key for them' do
        body = JSON.generate(name: "Athena Dao", email: "athenadao@bestgirlever.com", password: "treats4lyf", password_confirmation: "treats4lyf")
        
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
      end
    end

    describe 'when params are missing' do
      it 'returns a status 400 and an error message' do
        body = JSON.generate(name: "Athena Dao")
        
        post '/api/v1/users', headers: headers, params: body

        expect(response).to have_http_status(400)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a(Hash)
        expect(result[:errors].first).to have_key(:status)
        expect(result[:errors].first).to have_key(:message)
        expect(result[:errors].first).to have_key(:code)
        expect(result[:errors][0][:message]).to eq(["Email can't be blank", "Password can't be blank", "Password confirmation can't be blank"])
      end
    end

    describe 'if an email address is not unique' do
      it 'returns an error message' do
        body = JSON.generate(name: "Jim Beans", email: "jim@beans.com", password: "beans", password_confirmation: "beans")
        post '/api/v1/users', headers: headers, params: body
        expect(response).to have_http_status(201)

        body = JSON.generate(name: "Jimmy Beans", email: "jim@beans.com", password: "beans", password_confirmation: "beans")
        post '/api/v1/users', headers: headers, params: body

        expect(response).to have_http_status(400)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:errors].first[:message]).to eq(["Email has already been taken"])
      end
    end

    describe 'if a password does not match the password confirmation' do
      it 'returns an error message' do
        body = JSON.generate(name: "Jim Beans", email: "jim@beans.com", password: "beans", password_confirmation: "beanz")
        post '/api/v1/users', headers: headers, params: body
        expect(response).to have_http_status(400)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:errors].first[:message]).to eq(["Password confirmation doesn't match Password"])
      end
    end
  end

  describe 'POST /api/v1/sessions' do
    let!(:user) {User.create!(name: "Jim Beans", email: "jim@beans.com", password: "beans", password_confirmation: "beans")}
    describe 'when username and password are registered and correct' do
      it 'logs in a user and returns a response with user information' do
        body = JSON.generate(email: "jim@beans.com", password: "beans")

        post '/api/v1/sessions', headers: headers, params: body

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to be_a(String)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:attributes].count).to eq(3)
        expect(result[:data][:attributes][:name]).to be_a(String)
        expect(result[:data][:attributes][:email]).to be_a(String)
        expect(result[:data][:attributes][:api_key]).to be_a(String)
      end
    end

    describe 'when password is incorrect' do
      it 'returns an error message and 401 status' do
        body = JSON.generate(email: "jim@beans.com", password: "beanz")

        post '/api/v1/sessions', headers: headers, params: body

        expect(response).to have_http_status(401)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:errors].first[:message]).to eq("Incorrect password")
      end
    end

    describe 'when the email does not match any user' do
      it 'returns an error message and 404 status' do
        body = JSON.generate(email: "jimmy@beans.com", password: "beans")

        post '/api/v1/sessions', headers: headers, params: body

        expect(response).to have_http_status(404)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:errors].first[:message]).to eq("Incorrect email")
      end
    end
  end
end