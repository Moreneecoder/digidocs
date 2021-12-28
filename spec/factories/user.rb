FactoryBot.define do
  factory :user do
    name { Faker::Movies::StarWars.character }
    phone { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
  end
end
