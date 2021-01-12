FactoryBot.define do
  factory :message do
    body { 'MyText' }
    read { false }
  end
end
