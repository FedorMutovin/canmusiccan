require 'rails_helper'

describe 'User can search tracks from spotify', "
 In order to search tracks from spotify
 As an authenticated user
 I'd like to be able to search tracks from spotify
" do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit user_path(user)
  end

  it 'search track', js: true do
    fill_in 'track_name', with: 'Love'
    click_on I18n.t('spotify_tracks.search.search')
    expect(page).to have_css 'audio'
    expect(page).to have_css 'img'
    expect(page).to have_content I18n.t('spotify_tracks.add_track')
  end

  it 'is not search track', js: true do
    fill_in 'track_name', with: ''
    click_on I18n.t('spotify_tracks.search.search')
    within '.search-spotify-tracks' do
      expect(page).not_to have_css 'audio'
      expect(page).not_to have_css 'img'
      expect(page).not_to have_content I18n.t('spotify_tracks.add_track')
    end
  end
end
