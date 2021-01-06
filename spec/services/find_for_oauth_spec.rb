require 'rails_helper'

RSpec.describe FindForOauth do
  subject(:find_for_oauth) { described_class.new(auth) }

  let!(:user) { create(:user) }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }

  context 'when user already has authorization' do
    it 'returns the user' do
      user.authorizations.create(provider: 'github', uid: '123456')
      expect(find_for_oauth.call).to eq user
    end
  end

  context 'when user has not authorization' do
    context 'when user already exists' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: user.email }) }

      it 'does not create new user' do
        expect { find_for_oauth.call }.not_to change(User, :count)
      end

      it 'creates authorization for user' do
        expect { find_for_oauth.call }.to change(user.authorizations, :count).by(1)
      end

      it 'creates authorization with provider and uid' do
        authorization = find_for_oauth.call.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end

      it 'returns the user' do
        expect(find_for_oauth.call).to eq user
      end
    end

    context 'when user does not exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'new@user.com' }) }

      it 'creates new user' do
        expect { find_for_oauth.call }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(find_for_oauth.call).to be_a(User)
      end

      it 'fills user email' do
        user = find_for_oauth.call
        expect(user.email).to eq auth.info[:email]
      end

      it 'creates authorization for user' do
        user = find_for_oauth.call
        expect(user.authorizations).not_to be_empty
      end

      it 'creates authorization with provider and uid' do
        authorization = find_for_oauth.call.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end

    context 'when provider not return email' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'new@user.com' }) }

      it 'oauth_provider not return email' do
        expect { find_for_oauth.call }.to change(User, :count).by(1)
      end
    end

    context 'when oauth_provider not return email and email already exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { user_email: user.email }) }

      it { expect { find_for_oauth.call }.not_to change(User, :count) }
    end
  end
end
