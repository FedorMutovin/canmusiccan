require 'rails_helper'

describe 'User can sign in', "
 In order to use canmusiccan
 As an unauthenticated user
 I'd like to be able to sign in
" do
  let(:user) { create(:user) }

  before { visit new_user_session_path }

  it 'Registered user tries to sign in' do
    I18n.default_locale
    fill_in 'Email', with: user.email
    fill_in I18n.t('devise.sessions.new.password'), with: user.password
    within '.actions' do
      click_on I18n.t('devise.sessions.new.log_in')
    end
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  it 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in I18n.t('devise.sessions.new.password'), with: '12345678'
    within '.actions' do
      click_on I18n.t('devise.sessions.new.log_in')
    end

    expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'Email')
  end

  describe 'Sign in with ouath services', js: true do
    %w[Spotify Facebook].each do |network|
      before do
        clean_mock_auth(network)
      end

      describe 'Registered user' do
        it 'try to sign in' do
          mock_auth_hash(network.downcase, email: user.email)
          click_on "Sign in with #{network}"
          expect(page).to have_content "Successfully authenticated from #{network.capitalize} account."
        end

        it 'try to sign in with failure' do
          failure_mock_auth(network.downcase)
          click_on "Sign in with #{network}"
          expect(page).to have_content "Could not authenticate you from #{network} because \"Invalid credentials\"."
        end
      end

      describe 'Unregistered user' do
        context "#{network} return email" do
          it 'try to sign in' do
            mock_auth_hash(network.downcase, email: 'test@mail.ru')
            click_on "Sign in with #{network}"
            expect(page).to have_content "Successfully authenticated from #{network.capitalize} account."
          end
        end

        context "#{network} not return email" do
          it 'try type exist email' do
            mock_auth_hash(network.downcase, email: nil)
            click_on "Sign in with #{network}"
            expect(page).to have_content 'Add your email address for sign in'
            fill_in 'Email', with: user.email
            click_on 'Add email'
            expect(page).to have_content 'Email has already been taken'
          end
        end
      end
    end
  end
end
