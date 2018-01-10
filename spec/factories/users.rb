FactoryGirl.define do
    factory :user do
        name { Faker::Name.name }
        email 'foot@ball.com'
    end
end
