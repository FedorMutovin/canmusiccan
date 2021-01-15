require 'rails_helper'

describe 'User can see all of communities', "
 In order to have to be to see all of communities
 As an authenticated user
 I'd like to be able to see all of communities
" do
  let(:user) { create(:user) }
  let(:creator) { create(:user) }
  let!(:community) { create(:community, :with_avatar, creator: creator) }

  it 'Authenticated user try to see communities' do
    sign_in(user)
    visit communities_path
    expect(page).to have_content community.name
    expect(page).to have_css 'img'
  end

  it 'Unauthenticated user try to see communities ' do
    visit communities_path
    expect(page).not_to have_content community.name
  end
end
