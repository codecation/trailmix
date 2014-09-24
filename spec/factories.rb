FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }

  factory :user do
    email
    password 'abc123'
  end

  factory :entry do
    user
    body 'Entry body'
  end
end
