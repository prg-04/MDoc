class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  # validate :doctor_availability

  private

  def doctor_availability
    return unless Doctor.exists?(id: doctor_id) && doctor_has_conflicting_appointment?

    errors.add(:time, 'Doctor already has an appointment at this time.')
  end

  def doctor_has_conflicting_appointment?
    Appointment.where(doctor_id:, time: time.beginning_of_day..time.end_of_day).exists?
  end
end
