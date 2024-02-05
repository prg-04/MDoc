require 'swagger_helper'

RSpec.describe 'Doctors API', type: :request do
  path '/doctors' do
    get 'Retrieves a list of doctors' do
      produces 'application/json'

      response '200', 'list of doctors retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   first_name: { type: :string },
                   last_name: { type: :string },
                   specialization: { type: :string }
                 },
                 required: %w[first_name last_name specialization]
               }

        let(:new_patient) { create(:patient) }
        before { sign_in new_patient }
        let!(:doctor1) { create(:doctor) }
        let!(:doctor2) { create(:doctor) }

        run_test! do |response|
          json_response = JSON.parse(response.body)
          expect(json_response.size).to eq(Doctor.count)
          expect(json_response[0]['first_name']).to eq(doctor1.first_name)
          expect(json_response[0]['last_name']).to eq(doctor1.last_name)
          expect(json_response[0]['specialization']).to eq(doctor1.specialization)

          expect(json_response[1]['first_name']).to eq(doctor2.first_name)
          expect(json_response[1]['last_name']).to eq(doctor2.last_name)
          expect(json_response[1]['specialization']).to eq(doctor2.specialization)
        end
      end
    end

    # Other actions like POST, with, invalid parameters, etc.
  end

  path '/doctors/{id}' do
    parameter name: 'id', in: :path, type: :integer

    get 'Retrieves a single doctor' do
      produces 'application/json'

      response '200', 'doctor retrieved' do
        schema type: :object,
               properties: {
                 first_name: { type: :string },
                 last_name: { type: :string },
                 specialization: { type: :string }
               },
               required: %w[first_name last_name specialization]

        let(:new_patient) { create(:patient) }
        before { sign_in new_patient }
        let!(:doctor) { create(:doctor) }
        let(:id) { doctor.id }

        run_test! do |response|
          json_response = JSON.parse(response.body)
          expect(json_response['first_name']).to eq(doctor.first_name)
          expect(json_response['last_name']).to eq(doctor.last_name)
          expect(json_response['specialization']).to eq(doctor.specialization)
        end
      end

      response '404', 'doctor not found' do
        let(:new_patient) { create(:patient) }
        before { sign_in new_patient }
        let(:id) { '999' }

        run_test! do |response|
          expect(response).to have_http_status(404)
        end
      end
    end

    # Other actions like PUT, with, invalid parameters, etc.
  end

  # Other paths like POST, PUT, DELETE, etc.
end
