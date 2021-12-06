FactoryBot.define do
  factory :appointment do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    time { Faker::Number.number(10) }
    user_id { nil }
    doctor_id { nil }
  end
end
