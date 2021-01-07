FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    confirmed_at { Time.current }

    trait :with_demotrack do
      before :create do |user|
        user.demotracks.attach(io: File.open(Rails.root.join('spec/audio/demotrack.mp3')), filename: 'demotrack.mp3')
      end
    end
  end
end
