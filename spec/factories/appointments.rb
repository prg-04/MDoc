FactoryBot.define do
  factory :appointment do
    doctor_id { Doctor.first.id }
    patient_id { Patient.first.id }
    time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30) }
    city { Faker::Address.city }
  end
end
