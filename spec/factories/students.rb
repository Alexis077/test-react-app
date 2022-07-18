FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    last_name { Faker::Name.first_name }
  end
end
