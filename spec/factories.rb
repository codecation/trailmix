FactoryBot.define do
  sequence(:email) { |n| "user-#{n}@example.com" }
  sequence(:stripe_customer_id) { |n| "cus_#{n}" }

  factory :user do
    email
    password { 'abc123' }
  end

  factory :entry do
    user
    date { Time.zone.now }
    body { 'Entry body' }

    trait :with_photo do
      photo do
        Rack::Test::UploadedFile.new(
          Rails.root.join("spec", "fixtures", "files", "photo.jpg")
        )
      end
    end
  end

  factory :subscription do
    user
    stripe_customer_id
  end

  factory :import do
    user
  end

  factory :griddler_email, class: OpenStruct do
    to { [{
      full: "to_user@example.com",
      email: "to_user@example.com",
      token: "to_user",
      host: "example.com",
      name: nil
    }] }
    from { ({ email: "from_user@example.com" }) }
    subject { "Hello Trailmix" }
    body { "Today was great" }
  end
end
