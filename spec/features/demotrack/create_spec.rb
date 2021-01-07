require 'rails_helper'

describe 'User can add his demotracks', "
 In order to have to be able to show my demotracks
 As an authenticated user
 I'd like to be able to add demotracks
" do
  let!(:user) { create(:user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit user_path(user)
    end

    it 'tries to add demotrack.mp3', js: true do
      attach_file I18n.t('demotracks.form.new_demotrack'), Rails.root.join('spec/audio/demotrack.mp3')
      click_on I18n.t('demotracks.form.add_demotrack')
      expect(page).to have_link 'demotrack.mp3'
      expect(page).to have_css 'audio'
    end

    it 'tries to add demotrack without attach file', js: true do
      click_on I18n.t('demotracks.form.add_demotrack')
      expect(page).not_to have_css 'audio'
    end

    it 'tries to add avatar.jpg', js: true do
      attach_file I18n.t('demotracks.form.new_demotrack'), Rails.root.join('spec/images/avatar.jpg')
      click_on I18n.t('demotracks.form.add_demotrack')
      expect(page).to have_content I18n.t('demotracks.format_error')
      expect(page).not_to have_link 'avatar.jpg'
      expect(page).not_to have_css 'audio'
    end
  end
end
