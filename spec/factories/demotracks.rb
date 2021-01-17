FactoryBot.define do
  factory :demotrack do
    trait :with_audio do
      before :create do |demotrack|
        demotrack.audio.attach(io: File.open(Rails.root.join('spec/audio/demotrack.mp3')), filename: 'demotrack.mp3')
      end
    end
  end
end
