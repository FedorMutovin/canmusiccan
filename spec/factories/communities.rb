FactoryBot.define do
  factory :community do
    description { 'description' }
    name { 'community' }

    trait :with_avatar do
      before :create do |community|
        community.avatar.attach(io: File.open(Rails.root.join('spec/images/avatar.jpg')), filename: 'avatar.jpg')
      end
    end
  end
end
