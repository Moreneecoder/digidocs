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

    context 'when user endpoint tries to create a doctor' do
      let(:valid_attributes) do
        { name: 'Learn Elm', phone: '12345678901', email: 'foo@bar.com', is_doctor: true }
      end
      before { post '/api/v1/users', params: valid_attributes }

      it 'returns forbidden status code 403' do
        expect(response).to have_http_status(403)
      end

      it 'returns a forbidden request failure message' do
        expect(json['error'])
          .to eq("Can't create doctor from a /api/v1/users endpoint")
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /api/v1/users/:id' do
    let(:valid_attributes) { { name: 'Chun Li' } }

    context 'when the record exists' do
      before { put "/api/v1/users/#{user_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /api/v1/users/:id' do
    before { delete "/api/v1/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
