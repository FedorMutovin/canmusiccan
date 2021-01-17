require 'rails_helper'

describe 'User can delete demotracks', "
  If I need to delete my demotrack
  As an authenticated user
  I'd like to be able to delete my demotrack
" do
  let(:user) { create(:user) }
  let!(:demotrack) { create(:demotrack, :with_audio, user: user) }

  before { sign_in(user) }

  it 'delete demotrack', js: true do
    visit user_path(user)
    click_on I18n.t('demotracks.demotrack.delete_track')
    expect(page).not_to have_link 'demotrack.mp3'
    expect(page).not_to have_css 'audio'
  end
end
