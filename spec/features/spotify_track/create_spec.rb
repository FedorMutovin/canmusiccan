require 'rails_helper'

describe 'User can add spotify tracks to his collection', "
 In order to listen my tracks from spotify
 As an authenticated user
 I'd like to be able to add track to my collection
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in(user) }

  it 'create track', js: true do
    visit user_path(user)
    click_on I18n.t('users.show.spotify_tracks')
    within '#tracks-from-spotify' do
      expect(page).not_to have_css 'audio'
      expect(page).not_to have_css 'img'
    end
    fill_in 'track_name', with: 'Love'
    click_on I18n.t('spotify_tracks.search.search')
    within '.found-spotify-tracks' do
      expect(page).to have_css 'audio'
      expect(page).to have_css 'img'
      expect(page).to have_content I18n.t('spotify_tracks.add_track')
      first('.btn-outline-success').click
    end
    within ".tracks-#{user.id}" do
      expect(page).to have_css 'audio'
      expect(page).to have_css 'img'
    end
  end

  it 'user create track on other_user page', js: true do
    visit user_path(other_user)
    click_on I18n.t('users.show.spotify_tracks')
    within '.profile-tabs' do
      expect(page).not_to have_css 'audio'
      expect(page).not_to have_css 'img'
    end
    fill_in 'track_name', with: 'Love'
    click_on I18n.t('spotify_tracks.search.search')
    within '.found-spotify-tracks' do
      expect(page).to have_css 'audio'
      expect(page).to have_css 'img'
      expect(page).to have_content I18n.t('spotify_tracks.add_track')
      first('.btn-outline-success').click
    end
    visit user_path(user)
    click_on I18n.t('users.show.spotify_tracks')
    within '.profile-tabs' do
      expect(page).to have_css 'audio'
      expect(page).to have_css 'img'
    end
  end
end
