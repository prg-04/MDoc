class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

   delegate :first_name, to: :doctor, prefix: true
  delegate :first_name, to: :patient, prefix: true
end
