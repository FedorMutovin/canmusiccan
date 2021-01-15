require 'rails_helper'

describe 'User can follow for other user', "
 In order to follow for other user
 As an authenticated user
 I'd like to be able to to follow for other user
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:community) { create(:community, creator: other_user) }

  before { sign_in(user) }

  context 'when user follow to other user' do
    it 'create follow', js: true do
      visit user_path(other_user)
      click_on I18n.t('follows.form.follow')
      expect(page).to have_content I18n.t('follows.form.unfollow')
    end
  end

  context 'when user follow to community' do
    it 'create follow', js: true do
      visit communities_path
      click_on community.name
      click_on I18n.t('follows.form.follow')
      expect(page).to have_content I18n.t('follows.form.unfollow')
    end
  end
end
