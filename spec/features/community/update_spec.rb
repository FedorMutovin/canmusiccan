require 'rails_helper'

describe 'User can create a community', "
 In order to unite users by interests
 As an authenticated user
 I'd like to be able to create a community
" do
  let(:creator) { create(:user) }
  let!(:community) { create(:community, :with_avatar, creator: creator) }

  it 'try to update community with valid attributes' do
    sign_in(creator)
    visit communities_path
    click_on community.name
    click_on I18n.t('communities.show.edit')
    fill_in I18n.t('communities.form.name'), with: 'Name'
    fill_in I18n.t('communities.form.description'), with: 'Description'
    attach_file I18n.t('communities.form.avatar'), Rails.root.join('spec/images/avatar.jpg')
    click_on I18n.t('communities.form.save')
    expect(page).to have_content 'Name'
    expect(page).to have_css 'img'
    expect(page).to have_content 'Description'
  end

  it 'try to create community with invalid attributes' do
    sign_in(creator)
    visit communities_path
    click_on community.name
    click_on I18n.t('communities.show.edit')
    fill_in I18n.t('communities.form.name'), with: ''
    fill_in I18n.t('communities.form.description'), with: 'Description'
    attach_file I18n.t('communities.form.avatar'), Rails.root.join('spec/images/avatar.jpg')
    click_on I18n.t('communities.form.save')
    expect(page).to have_content "Name can't be blank"
  end
end
