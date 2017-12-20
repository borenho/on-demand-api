# By wrapping faker methods in a block,
# we ensure that faker generates dynamic data every time the factory is invoked. This way, we always have unique data.
FactoryGirl.define do
    factory :merchant do
        name { Faker::Name.name }
        created_by { Faker::Number.number(10) }
    end
end

