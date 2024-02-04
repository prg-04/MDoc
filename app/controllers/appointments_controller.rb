class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]

  # GET /appointments
   def index
    @appointments = current_patient.appointments.includes(:doctor)
    
     puts "Appointments: #{@appointments.inspect}"

    render json: @appointments.to_json(include: { doctor: { only: :first_name } })
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    @appointment = current_patient.appointments.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = current_patient.appointments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:time, :doctor_id, :city)
  end

end
