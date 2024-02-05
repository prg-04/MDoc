# spec/requests/patients_request_spec.rb
require 'rails_helper'

RSpec.describe 'Patients API', type: :request do
  let(:new_patient) { create(:patient) }

  before do
    sign_in new_patient
    Patient.destroy_all
  end

  describe 'GET /patients' do
    it 'returns a list of patients' do
      # Create some patients to test
      create_list(:patient, 3)

      # Make the request
      get '/patients'

      # Check the response
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      # Parse the JSON response
      patients = JSON.parse(response.body)

      # Assuming your Patient model has first_name and last_name attributes
      expect(patients.count).to eq(3)
      expect(patients[0]['first_name']).to be_present
      expect(patients[0]['last_name']).to be_present

      expect(Patient.count).to eq(3)
    end
  end

  describe 'GET /patients/1' do
    let(:patient) { create(:patient) }

    it 'returns a single patient' do
      # Make the request
      get "/patients/#{patient.id}"

      # Check the response
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      # Parse the JSON response
      patient_response = JSON.parse(response.body)

      expect(patient_response['id']).to eq(patient.id)
      expect(patient_response['first_name']).to eq(patient.first_name)
      expect(patient_response['last_name']).to eq(patient.last_name)

      expect(Patient.count).to eq(1)
    end

    it 'returns 404 if patient is not found' do
      # Make the request with an invalid patient id
      get '/patients/999'

      # Check the response
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /patients' do
    let(:valid_params) do
      { patient: { first_name: 'John', last_name: 'Doe', email: 'name@email.com', password: 'password' } }
    end
    let(:invalid_params) { { patient: { invalid_attribute: 'Invalid' } } }

    it 'creates a new patient with valid params' do
      expect do
        # Make the request
        post '/patients', params: valid_params
      end.to change(Patient, :count).by(1)

      # Check the response
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      # Parse the JSON response
      patient_response = JSON.parse(response.body)

      expect(patient_response['first_name']).to eq('John')
      expect(patient_response['last_name']).to eq('Doe')
    end

    it 'returns unprocessable entity with invalid params' do
      expect do
        # Make the request with invalid params
        post '/patients', params: invalid_params
      end.not_to change(Patient, :count)

      # Check the response
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH/PUT /patients/:id' do
    let!(:patient) { create(:patient) }
    let(:valid_params) { { patient: { first_name: 'New', last_name: 'Name' } } }
    let(:invalid_params) { { patient: { invalid_attribute: 'Invalid' } } }

    it 'updates the patient with valid params' do
      # Make the request
      patch "/patients/#{patient.id}", params: valid_params

      # Reload the patient from the database
      patient.reload

      # Check the response
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      # Parse the JSON response
      patient_response = JSON.parse(response.body)

      expect(patient_response['first_name']).to eq('New')
      expect(patient_response['last_name']).to eq('Name')
    end
  end

  describe 'DELETE /patients/:id' do
    let!(:patient) { create(:patient) }

    it 'deletes the patient' do
      # Count the number of patients before the request
      expect do
        delete "/patients/#{patient.id}"
      end.to change(Patient, :count).by(-1)

      # Check the response
      expect(response).to have_http_status(:no_content)
    end

    it 'returns not found for non-existent patient' do
      # Delete the patient first
      patient.destroy

      # Attempt to delete the patient again
      delete "/patients/#{patient.id}"

      # Check the response
      expect(response).to have_http_status(:not_found)
    end
  end
end
