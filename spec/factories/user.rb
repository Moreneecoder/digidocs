FactoryBot.define do
    factory :user do
      name { Faker::Movies::StarWars.character }
      phone { Faker::Number.number(10) }
      name { Faker::Lorem.word }
    end
end