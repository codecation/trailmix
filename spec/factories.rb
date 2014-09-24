FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }

  factory :user do
    email
    password 'abc123'
    stripe_customer_id 'cus_4phNjusXeulx1R'
  end

  factory :entry do
    user
    body 'Entry body'
  end
end
