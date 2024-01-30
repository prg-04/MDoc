class Patients::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_patient, _opts = {})
    render json: {
      code: 200,
      message: 'Logged in successfully.',
      data: { patient: PatientSerializer.new(current_patient).serializable_hash[:data][:attributes] }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first
      current_patient = Patient.find(jwt_payload['sub'])
    end

    if current_patient
      render json: {
        code: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        code: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
