require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  let!(:user) { create(:user) }
  let!(:doctor) { create(:user, is_doctor: true, office_address: '11, Adewale close, Lagos') }
  let!(:appointments) { create_list(:appointment, 10, user_id: user.id, doctor_id: doctor.id) }
  let(:appointment_id) { appointments.first.id }
  let(:user_id) {user.id}
  let(:doctor_id) {doctor.id}

  describe 'GET /api/v1/users/:user_id/appointments}' do
    before { get "/api/v1/users/#{user_id}/appointments" }

    context 'appointments exist' do
      it "returns users' list of appointments" do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when appointments does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end

    context 'when appointments exist for doctor' do
      before { get "/api/v1/doctors/#{doctor_id}/appointments" }

      it "returns doctors' list of appointments" do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end      
    end
  end

  # Test suite for GET /api/v1/users/:user_id/appointments/:id'
  describe 'GET /api/v1/users/:user_id/appointments/:id' do
    before { get "/api/v1/users/#{user_id}/appointments/#{appointment_id}" }

    context 'when user appointment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the single appointment' do
        expect(json['id']).to eq(appointment_id)
      end
    end

    context 'when user appointment does not exist' do
      let(:appointment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end

    context 'when doctor appointment exist' do
      before { get "/api/v1/doctors/#{doctor_id}/appointments/#{appointment_id}" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the single doctor appointment' do
        expect(json['id']).to eq(appointment_id)
      end
    end
  end

  # Test suite for POST /api/v1/users/:user_id/appointments/'
  describe 'POST /api/v1/users/:user_id/appointments/' do
    let(:valid_params) do
      { user_id: user_id, doctor_id: doctor_id, title: 'Tooth Ache Treatment', description: 'I wan see you ooo', time: rand(1.year).seconds.ago }
    end

    context 'when request params are valid' do
      before { post "/api/v1/users/#{user_id}/appointments", params: valid_params }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/users/#{user_id}/appointments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end

    context 'when doctor tries to create appointment' do
      before { post "/api/v1/doctors/#{doctor_id}/appointments", params: valid_params }

      it 'returns forbidden status code of 403' do
        expect(response).to have_http_status(403)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Doctors cannot create appointment/)
      end
    end
    
  end

end
