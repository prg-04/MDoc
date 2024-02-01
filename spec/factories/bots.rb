FactoryBot.define do
  factory :patient do
    # Define the attributes you want for your patient model
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }
  end

  factory :doctor do
    # Define the attributes you want for your patient model
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    specialization do
      [
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
      ].sample
    end
    image { Faker::Avatar.image }
    bio { Faker::Lorem.paragraph }
    fee { Faker::Number.between(from: 100, to: 1000) }
  end
end
