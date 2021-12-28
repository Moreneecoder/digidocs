FactoryBot.define do
  factory :appointment do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    time { rand(1.years).seconds.ago }
    user_id { nil }
    doctor_id { nil }
  end
end
