require 'rails_helper'

def create_new_appointment(doctor, patient)
  Appointment.create!(
    doctor_id: doctor.id,
    patient_id: patient.id,
    time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30)
  )
end

RSpec.describe 'Appointments API', type: :request do
  let!(:new_doctor) { create(:doctor) }
  let!(:new_patient) { create(:patient) }

  before do
    sign_in new_patient
    Appointment.destroy_all
  end

  describe 'GET /appointments' do
    it 'returns a list of appointments for the authenticated patient' do
      3.times do
        create_new_appointment(new_doctor, new_patient)
      end
      get '/appointments'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      # Parse the JSON response
      appointments_response = JSON.parse(response.body)

      # Add expectations based on your data model and serialization
      expect(appointments_response.size).to eq(3)
    end

    it 'returns unauthorized without authentication' do
      # Clear authentication for this example
      sign_out new_patient

      get '/appointments'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /appointments/1' do
    it 'returns details for a specific appointment' do
      appointment = create_new_appointment(new_doctor, new_patient)
      get "/appointments/#{appointment.id}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      # Parse the JSON response
      appointment_response = JSON.parse(response.body)

      # Add expectations based on your data model and serialization
      expect(appointment_response['doctor_id']).to eq(new_doctor.id)
      expect(appointment_response['patient_id']).to eq(new_patient.id)
      expect(appointment_response['time']).to be_present
    end

    it 'returns not found for a non-existing appointment' do
      get '/appointments/999'

      expect(response).to have_http_status(:not_found)
    end

    it 'returns unauthorized without authentication' do
      appointment = create_new_appointment(new_doctor, new_patient)

      # Clear authentication for this example
      sign_out new_patient

      get "/appointments/#{appointment.id}"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /appointments' do
    let(:patient) { create(:patient) }
    let(:valid_attributes) { attributes_for(:appointment, patient_id: patient.id) }

    context 'with valid parameters' do
      it 'creates a new appointment' do
        expect do
          post '/appointments', params: { appointment: valid_attributes }
        end.to change(Appointment, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Parse the JSON response
        appointment_response = JSON.parse(response.body)

        # Add expectations based on your data model and serialization
        expect(appointment_response['time']).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        post '/appointments', params: { appointment: { time: nil, doctor_id: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it 'returns unauthorized without authentication' do
      # Clear authentication for this example
      sign_out new_patient

      post '/appointments', params: { appointment: valid_attributes }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PATCH /appointments/1' do
    let(:new_appointment) { create(:appointment) }
    # let(:updated_attributes) { DateTime.now + 1.hour }

    context 'with valid parameters' do
      it 'updates the specified appointment' do
        # new_appointment = create(:appointment)
        updated_time = DateTime.now
        puts "updated_time: #{updated_time}"
        puts "new_appointment: #{new_appointment.id}"
        patch "/appointments/#{new_appointment.id}", params: { appointment: { time: updated_time } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Parse the JSON response
        appointment_response = JSON.parse(response.body)

        # Add expectations based on your data model and serialization
        expect(appointment_response['time']).to eq(updated_time)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        patch "/appointments/#{appointment.id}", params: { appointment: { time: nil, doctor_id: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it 'returns unauthorized without authentication' do
      # Clear authentication for this example
      sign_out new_patient

      patch "/appointments/#{appointment.id}", params: { appointment: updated_attributes }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
