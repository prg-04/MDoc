# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create 10 doctors
SPECIALIZATIONS = [
  'Cardiologist',
  'Dermatologist',
  'Endocrinologist',
  'Gastroenterologist',
  'Neurologist',
  'Ophthalmologist',
  'Orthopedic Surgeon',
  'Pediatrician',
  'Psychiatrist',
  'Urologist'
]

def select_random_specialization
  SPECIALIZATIONS.sample
end

10.times do
  Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    specialization: select_random_specialization,
    image: Faker::Avatar.image,
    bio: Faker::Lorem.paragraph,
    fee: Faker::Number.between(from: 100, to: 1000)
  )
end

# Create 10 patients
100.times do
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password",
  )
end

# Create 10 appointments
1000.times do
  Appointment.create!(
    doctor_id: Faker::Number.between(from: 1, to: 10),
    patient_id: Faker::Number.between(from: 1, to: 10),
    time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30)
  )
end
