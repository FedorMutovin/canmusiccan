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

    expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: "Email")
  end
end
