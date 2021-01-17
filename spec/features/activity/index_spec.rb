require 'rails_helper'

describe 'User can see activities', "
 In order to see activities of following users
 As an follower
 I'd like to be able see their activities
" do
  let(:followable_user) { create(:user) }
  let(:follower_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, postable: followable_user) }
  let!(:user_follow) { create(:follow, followable: followable_user, follower: follower_user) }
  let!(:activity) { create(:activity, trackable: post, owner: followable_user) }

  context 'when not follower' do
    it 'try to see activity' do
      sign_in(other_user)
      visit root_path
      expect(page).not_to have_content I18n.t('public_activity.post.create.added_post')
      expect(page).not_to have_content activity.trackable.body
    end
  end

  context 'when unauthenticated user' do
    it 'try to see activity' do
      visit root_path
      expect(page).not_to have_content I18n.t('public_activity.post.create.added_post')
      expect(page).not_to have_content activity.trackable.body
    end
  end
end
