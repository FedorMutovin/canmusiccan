require 'rails_helper'

describe 'User can change his information', "
 In order to change account information
 As an authenticated user
 I'd like to be able to change my information
" do
  let!(:user) { create(:user) }

  before do
    sign_in(user)
    visit edit_user_registration_path
  end

  describe 'Authenticated user' do
    it 'tries to edit his email' do
      fill_in 'Email', with: 'mi@mail.ru'
      fill_in I18n.t('devise.registrations.edit.current_password'), with: user.password
      click_on I18n.t('devise.registrations.edit.update')
      expect(page).to have_content I18n.t('devise.registrations.update_needs_confirmation')
      open_email('mi@mail.ru')
      current_email.click_link 'Confirm my account'
      expect(page).to have_content I18n.t('devise.confirmations.confirmed')
    end

    it 'tries to edit his password' do
      fill_in I18n.t('devise.registrations.edit.password'), with: '12345678'
      fill_in I18n.t('devise.registrations.edit.password_confirmation'), with: '12345678'
      fill_in I18n.t('devise.registrations.edit.current_password'), with: user.password
      click_on I18n.t('devise.registrations.edit.update')
      expect(page).to have_content I18n.t('devise.registrations.updated')
    end

    it 'tries to edit information with empty current_password' do
      fill_in 'Email', with: 'mi@mail.ru'
      click_on I18n.t('devise.registrations.edit.update')
      expect(page).to have_content "Current password can't be blank"
    end

    it 'tries to add avatar img' do
      attach_file I18n.t('devise.registrations.edit.avatar'), Rails.root.join('spec/images/avatar.jpg')
      fill_in I18n.t('devise.registrations.edit.current_password'), with: user.password
      click_on I18n.t('devise.registrations.edit.update')
      expect(page).to have_content I18n.t('devise.registrations.updated')
      visit edit_user_registration_path
      expect(page).to have_css("img[src*='avatar.jpg']")
    end
  end
end
