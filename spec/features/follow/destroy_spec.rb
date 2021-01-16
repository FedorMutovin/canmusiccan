require 'rails_helper'

describe 'User can unfollow for other user', "
 In order to unfollow for other user
 As an authenticated user
 I'd like to be able to to unfollow for other user
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:community) { create(:community, creator: other_user) }
  let!(:user_follow) { create(:follow, followable: other_user, follower: user) }
  let!(:community_follow) { create(:follow, followable: community, follower: user) }

  before { sign_in(user) }

  context 'when user unfollow to other user' do
    it 'unfollow', js: true do
      visit user_path(other_user)
      click_on I18n.t('follows.form.unfollow')
      expect(page).to have_content I18n.t('follows.form.follow')
    end
  end

  context 'when user unfollow to community' do
    it 'unfollow', js: true do
      visit communities_path
      click_on community.name
      click_on I18n.t('follows.form.unfollow')
      expect(page).to have_content I18n.t('follows.form.follow')
    end
  end
end
