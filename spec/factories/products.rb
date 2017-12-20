FactoryGirl.define do
    factory :product do
        name { Faker::StarWars.character }
        price { Faker::Number.number(1000) }
        merchant_id nil
    end
end