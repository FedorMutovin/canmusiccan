require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_many(:authorizations).dependent(:destroy) }

  it 'have one attached avatar' do
    expect(described_class.new.avatar).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it 'have many attached demotrack' do
    expect(described_class.new.demotracks).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe '.find_for_ouath' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'spotify', uid: '123456') }
    let(:service) { double('FindForOauth') }

    it 'calls FindForOauth' do
      expect(FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      described_class.find_for_oauth(auth)
    end
  end
end
