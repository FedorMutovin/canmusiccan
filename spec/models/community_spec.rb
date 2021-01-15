require 'rails_helper'

RSpec.describe Community, type: :model do
  it { is_expected.to have_many(:users).dependent(:destroy) }
  it { belong_to :creator }

  it 'have one attached avatar' do
    expect(described_class.new.avatar).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
