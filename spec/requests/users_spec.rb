require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  describe 'GET /users' do
    before { get '/api/v1/users' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /users/:id' do
    before { get "/api/v1/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user with the given id' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(users.first.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

    # Test suite for POST /todos
    describe 'POST /api/v1/users' do
      # valid payload
      let(:valid_attributes) { { name: 'Learn Elm', phone: '12345678901', email: 'foo@bar.com' } }
  
      context 'when the request is valid' do
        before { post '/api/v1/users', params: valid_attributes }
  
        it 'creates a user' do
          expect(json['message']).to eq('User Learn Elm created successfully')
        end
  
        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end
  
      context 'when the request is invalid' do
        before { post '/api/v1/users', params: { name: 'Foobar' } }
  
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
  
        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Phone can't be blank/)
        end
      end
    end
end
