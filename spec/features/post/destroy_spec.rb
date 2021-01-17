require 'rails_helper'

describe 'User or community can destroy his post', "
 In order to destroy a post
 As an authenticated user or community
 I'd like to be able to destroy a post
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'when user' do
    let!(:post) { create(:post, postable: user) }
    let!(:other_post) { create(:post, postable: other_user) }

    before { sign_in(user) }

    context 'when user try destroy his post' do
      it 'destroy a post', js: true do
        visit user_path(user)
        click_on I18n.t('users.show.posts')
        expect(page).to have_content post.body
        click_on I18n.t('posts.post.destroy')
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content post.body
      end
    end

    context 'when other user try destroy a post on other user page' do
      it 'is not destroy a post', js: true do
        visit user_path(other_user)
        click_on I18n.t('users.show.posts')
        expect(page).to have_content other_post.body
        expect(page).not_to have_content I18n.t('posts.posts.destroy')
      end
    end
  end

  context 'when community' do
    let(:user_community) { create(:community, creator: user) }
    let(:other_user_community) { create(:community, creator: other_user) }
    let!(:user_community_post) { create(:post, postable: user_community) }
    let!(:other_user_community_post) { create(:post, postable: other_user_community) }

    before { sign_in(user) }

    context 'when community try destroy it post' do
      it 'destroy a post', js: true do
        visit community_path(user_community)
        click_on I18n.t('communities.show.posts')
        expect(page).to have_content user_community_post.body
        click_on I18n.t('posts.post.destroy')
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content user_community_post.body
      end
    end

    context 'when not creator community try destroy a post' do
      it 'is not destroy a post', js: true do
        visit community_path(other_user_community)
        click_on I18n.t('communities.show.posts')
        expect(page).to have_content other_user_community_post.body
        expect(page).not_to have_button I18n.t('posts.posts.destroy')
      end
    end
  end
end
