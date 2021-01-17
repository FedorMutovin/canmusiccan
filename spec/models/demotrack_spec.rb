require 'rails_helper'

RSpec.describe Demotrack, type: :model do
  it { belong_to :user }

  it 'have one attached audio' do
    expect(described_class.new.audio).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
