require 'rails_helper'

describe 'User can show a community', "
 In order to have to show a community
 As an authenticated user
 I'd like to be able to show a community
" do
  let(:user) { create(:user) }
  let(:creator) { create(:user) }
  let!(:community) { create(:community, :with_avatar, creator: creator) }

  it 'Authenticated user try to see communities' do
    sign_in(user)
    visit communities_path
    click_on community.name
    expect(page).to have_content community.name
    expect(page).to have_css 'img'
    expect(page).to have_content community.description
  end
end
