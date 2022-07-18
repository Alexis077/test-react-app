FactoryBot.define do
  factory :course do
    name { Faker::Educator.unique.subject }
  end
end
