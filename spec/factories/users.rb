FactoryBot.define do
  factory :user do
    username {Faker::Internet.username}
    email {Faker::Internet.email}
    password {'1234567890'}
  end
end
