FactoryGirl.define do
    factory :user do
        name { Faker::Name.name }
        email 'foot@ball.com'
        password ' ball+foot '
    end
end
