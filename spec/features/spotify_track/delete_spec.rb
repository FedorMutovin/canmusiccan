require 'rails_helper'

describe 'User can delete his tracks from spotify', "
  If I need to delete my spotify tracks
  As an authenticated user
  I'd like to be able to delete my track
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:spotify_track) { create(:spotify_track, user: user) }
  let!(:other_spotify_track) { create(:spotify_track, user: other_user) }

  before { sign_in(user) }

  it 'delete spotify track', js: true do
    visit user_path(user)
    click_on I18n.t('users.show.spotify_tracks')
    expect(page).to have_css 'audio'
    expect(page).to have_css 'img'
    click_on I18n.t('spotify_tracks.spotify_track.delete_track')
    within '.profile-tabs' do
      expect(page).not_to have_css 'audio'
      expect(page).not_to have_css 'img'
    end
  end

  it 'is not delete spotify track', js: true do
    visit user_path(other_user)
    click_on I18n.t('users.show.spotify_tracks')
    expect(page).not_to have_content I18n.t('spotify_tracks.spotify_track.delete_track')
  end
end
