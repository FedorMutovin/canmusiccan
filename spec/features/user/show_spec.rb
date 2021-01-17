require 'rails_helper'

describe 'User can show his account page', "
 In order to show account information
 As an authenticated user
 I'd like to be able to show my account page
" do
  let(:current_user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:demotrack) { create(:demotrack, :with_audio, user: current_user) }

  describe 'Authenticated user' do
    it 'tries to show current_user account' do
      sign_in(current_user)
      expect(page).to have_link(href: user_path(current_user))
      visit user_path(current_user)
      expect(page).to have_link 'demotrack.mp3'
      expect(page).to have_css 'audio'
      expect(page).to have_content I18n.t('demotracks.demotrack.delete_track')
      expect(page).to have_content I18n.t('demotracks.form.new_demotrack')
    end

    it 'tries to show other_user account' do
      sign_in(other_user)
      visit user_path(other_user)
      expect(page).not_to have_link 'demotrack.mp3'
      expect(page).not_to have_css 'audio'
      expect(page).not_to have_content I18n.t('demotracks.demotrack.delete_track')
      expect(page).not_to have_content I18n.t('demotracks.form.add_demotrack')
    end
  end

  describe 'Unauthenticated user' do
    it 'tries to show user account' do
      expect(page).not_to have_link(href: user_path(current_user))
    end
  end
end
