require 'rails_helper'

RSpec.describe 'Doctors API', type: :request do
  let(:new_patient) { create(:patient) }

  before do
    sign_in new_patient
    Doctor.destroy_all
  end

  describe 'GET /doctors' do
    it 'returns a list of doctors' do
      # Create some sample doctors
      doctor1 = create(:doctor)
      doctor2 = create(:doctor)

      # Make the request to the index action
      get '/doctors'

      # Expect a successful response (HTTP status 200)
      expect(response).to have_http_status(200)

      # Parse the JSON response
      json_response = JSON.parse(response.body)

      # Expect the correct number of doctors in the response
      expect(json_response.size).to eq(Doctor.count)

      # Expect the response to include the attributes of the created doctors
      expect(json_response[0]['first_name']).to eq(doctor1.first_name)
      expect(json_response[0]['last_name']).to eq(doctor1.last_name)
      expect(json_response[0]['specialization']).to eq(doctor1.specialization)

      expect(json_response[1]['first_name']).to eq(doctor2.first_name)
      expect(json_response[1]['last_name']).to eq(doctor2.last_name)
      expect(json_response[1]['specialization']).to eq(doctor2.specialization)
    end
  end

  describe 'GET /doctors/:id' do
    it 'returns a single doctor' do
      # Create a sample doctor
      doctor = create(:doctor)

      # Make the request to the show action
      get "/doctors/#{doctor.id}"

      # Expect a successful response (HTTP status 200)
      expect(response).to have_http_status(200)

      # Parse the JSON response
      json_response = JSON.parse(response.body)

      # Expect the response to include the attributes of the created doctor
      expect(json_response['first_name']).to eq(doctor.first_name)
      expect(json_response['last_name']).to eq(doctor.last_name)
      expect(json_response['specialization']).to eq(doctor.specialization)
    end

    it 'returns a not found error if the doctor is not found' do
      # Make the request to the show action with an invalid ID
      get '/doctors/999'

      # Expect a not found response (HTTP status 404)
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /doctors' do
    context 'with valid parameters' do
      it 'creates a new doctor' do
        # Define valid parameters for creating a doctor
        valid_params = {
          doctor: {
            first_name: 'John',
            last_name: 'Doe',
            specialization: 'Cardiology',
            image: 'sample_image.jpg',
            bio: 'A dedicated cardiologist',
            fee: '100'
          }
        }

        # Make the request to the create action with valid parameters
        post '/doctors', params: valid_params

        # Expect a successful response (HTTP status 201 - Created)
        expect(response).to have_http_status(201)

        # Parse the JSON response
        json_response = JSON.parse(response.body)

        # Expect the response to include the attributes of the created doctor
        expect(json_response['first_name']).to eq('John')
        expect(json_response['last_name']).to eq('Doe')
        expect(json_response['specialization']).to eq('Cardiology')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        # Define invalid parameters for creating a doctor
        invalid_params = {
          doctor: {
            first_name: '', # Invalid: First name is blank
            last_name: 'Doe',
            specialization: 'Cardiology',
            image: 'sample_image.jpg',
            bio: 'A dedicated cardiologist',
            fee: '100'
          }
        }

        # Make the request to the create action with invalid parameters
        post '/doctors', params: invalid_params

        # Expect an unprocessable entity response (HTTP status 422)
        expect(response).to have_http_status(422)

        # Parse the JSON response
        json_response = JSON.parse(response.body)

        # Expect the response to include error details
        expect(json_response['first_name'][0]).to eq("can't be blank")
      end
    end
  end

  describe 'PUT /doctors/1' do
    let(:doctor) { create(:doctor) }

    context 'with valid parameters' do
      it 'updates the specified doctor' do
        # Define valid parameters for updating the doctor
        valid_params = {
          doctor: {
            first_name: 'Updated First Name'
          }
        }

        # Make the request to the update action with valid parameters
        put "/doctors/#{doctor.id}", params: valid_params

        # Expect a successful response (HTTP status 200 - OK)
        expect(response).to have_http_status(200)

        # Parse the JSON response
        json_response = JSON.parse(response.body)

        # Expect the response to include the updated attributes
        expect(json_response['first_name']).to eq('Updated First Name')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        # Define invalid parameters for updating the doctor
        invalid_params = {
          doctor: {
            first_name: '' # Invalid: First name is blank
          }
        }

        # Make the request to the update action with invalid parameters
        put "/doctors/#{doctor.id}", params: invalid_params

        # Expect an unprocessable entity response (HTTP status 422)
        expect(response).to have_http_status(422)

        # Parse the JSON response
        json_response = JSON.parse(response.body)

        # Expect the response to include error details
        expect(json_response['first_name'][0]).to eq("can't be blank")
      end
    end
  end

  describe 'DELETE /doctors/1' do
    let!(:doctor) { create(:doctor) }

    it 'deletes the specified doctor' do
      # Make the request to the destroy action for the specific doctor
      delete "/doctors/#{doctor.id}"

      # Expect a successful response (HTTP status 204 - No Content)
      expect(response).to have_http_status(204)

      # Verify that the doctor was actually deleted from the database
      expect { doctor.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'returns not found if the doctor does not exist' do
      # Attempt to delete a doctor with an invalid ID
      delete '/doctors/999'

      # Expect a not found response (HTTP status 404)
      expect(response).to have_http_status(404)
    end
  end
end
