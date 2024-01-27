class Patients::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_patient, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: PatientSerializer.new(current_patient).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: "Patient couldn't be created successfully. #{current_patient.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
