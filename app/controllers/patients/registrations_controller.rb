class Patients::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  include ActionController::Cookies
  respond_to :json

  private

  def respond_with(current_patient, _opts = {})
    # jwt_token = request.env['warden-jwt_auth.token']
    if resource.persisted?
      render json: {
        # token: jwt_token,
        code: 200,
        message: 'Signed up successfully.',
        data: PatientSerializer.new(current_patient).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        error:
        { message: "Patient couldn't be created successfully. #{current_patient.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
