require 'rails_helper'

describe 'User can delete demotracks', "
  If I need to delete my demotrack
  As an authenticated user
  I'd like to be able to delete my demotrack
" do
  let(:user) { create(:user) }

  describe 'Authenticated user' do
    before { sign_in(user) }

    it 'delete demotrack', js: true do
      user.demotracks.attach(io: File.open(Rails.root.join('spec/audio/demotrack.mp3')), filename: 'demotrack.mp3')
      visit user_path(user)
      click_on I18n.t('demotracks.demotracks.delete_track')
      expect(page).not_to have_link 'demotrack.mp3'
      expect(page).not_to have_css 'audio'
    end
  end
end
