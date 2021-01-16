FactoryBot.define do
  factory :post do
    body { '12' }

    trait :invalid do
      body { nil }
    end
  end
end
