require 'rails_helper'

describe 'User can create a community', "
 In order to unite users by interests
 As an authenticated user
 I'd like to be able to create a community
" do
  let(:user) { create(:user) }
  let(:creator) { create(:user) }
  let!(:community) { create(:community, :with_avatar, creator: creator) }

  it 'try to create community with valid attributes' do
    sign_in(user)
    visit communities_path
    click_on I18n.t('communities.index.new_community')
    fill_in I18n.t('communities.new.name'), with: 'Name'
    fill_in I18n.t('communities.new.description'), with: 'Description'
    attach_file I18n.t('communities.new.avatar'), Rails.root.join('spec/images/avatar.jpg')
    click_on I18n.t('communities.new.create')
    expect(page).to have_content 'Name'
    expect(page).to have_css 'img'
    expect(page).to have_content 'Description'
  end

  it 'try to create community with invalid attributes' do
    sign_in(user)
    visit communities_path
    click_on I18n.t('communities.index.new_community')
    fill_in I18n.t('communities.new.description'), with: 'Description'
    attach_file I18n.t('communities.new.avatar'), Rails.root.join('spec/images/avatar.jpg')
    click_on I18n.t('communities.new.create')
    expect(page).to have_content "Name can't be blank"
  end
end
