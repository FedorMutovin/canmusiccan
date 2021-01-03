require 'rails_helper'

describe 'User can sign up', "
 To start use canmusiccan
 As an authenticated user
 I'd like to be able to sign up
" do
  before { visit new_user_registration_path }

  it 'User tries to sign up' do
    save_and_open_page
    fill_in 'Email', with: 'user@user.user'
    fill_in I18n.t('devise.registrations.new.password'), with: '12345678'
    fill_in I18n.t('devise.registrations.new.password_confirmation'), with: '12345678'
    within '.actions' do
      click_on I18n.t('devise.registrations.new.sign_up')
    end
    open_email('user@user.user')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content I18n.t('devise.confirmations.confirmed')
  end

  it 'User tries to sign up with invalid fills' do
    fill_in I18n.t('devise.registrations.new.password'), with: '12345678'
    fill_in I18n.t('devise.registrations.new.password_confirmation'), with: '12345678'
    within '.actions' do
      click_on I18n.t('devise.registrations.new.sign_up')
    end
    expect(page).to have_content "Email can't be blank"
  end
end
