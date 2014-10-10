FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }
  sequence(:stripe_id) { |n| "cus_#{n}" }

  factory :user do
    email
    password 'abc123'
    stripe_id
  end

  factory :entry do
    user
    date Time.zone.now
    body 'Entry body'
  end

  factory :import do
    user
  end

  factory :griddler_email, class: OpenStruct do
    to [{
      full: "to_user@example.com",
      email: "to_user@example.com",
      token: "to_user",
      host: "example.com",
      name: nil
    }]
    from [{ email: "from_user@example.com" }]
    subject "Hello Trailmix"
    body "Today was great"
  end
end
