class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :doctor_id, :patient_id, :time, :city, presence: true
end
