require 'rails_helper'

describe 'User or community can create a post', "
 In order to create a post
 As an authenticated user or community
 I'd like to be able to create a post
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'when user' do
    before { sign_in(user) }

    context 'when user try create a post' do
      it 'create a post', js: true do
        visit user_path(user)
        click_on I18n.t('users.show.posts')
        fill_in I18n.t('posts.form.body'), with: 'body'
        click_on I18n.t('posts.form.create')
        expect(page).to have_content 'body'
      end

      it 'is not create a post', js: true do
        visit user_path(user)
        click_on I18n.t('users.show.posts')
        click_on I18n.t('posts.form.create')
        expect(page).to have_content "Body can't be blank"
      end
    end

    context 'when other user try create a post on other user page' do
      it 'is not create a post', js: true do
        visit user_path(other_user)
        click_on I18n.t('users.show.posts')
        expect(page).not_to have_content I18n.t('posts.form.title')
        expect(page).not_to have_content I18n.t('posts.form.body')
        expect(page).not_to have_button I18n.t('posts.form.create')
      end
    end
  end

  context 'when community' do
    let(:user_community) { create(:community, creator: user) }
    let(:other_user_community) { create(:community, creator: other_user) }

    before { sign_in(user) }

    context 'when community try create a post' do
      it 'create a post', js: true do
        visit community_path(user_community)
        click_on I18n.t('communities.show.posts')
        fill_in I18n.t('posts.form.body'), with: 'body'
        click_on I18n.t('posts.form.create')
        expect(page).to have_content 'body'
      end

      it 'is not create a post', js: true do
        visit community_path(user_community)
        click_on I18n.t('communities.show.posts')
        click_on I18n.t('posts.form.create')
        expect(page).to have_content "Body can't be blank"
      end
    end

    context 'when not creator community try create a post' do
      it 'is not create a post', js: true do
        visit community_path(other_user_community)
        click_on I18n.t('communities.show.posts')
        expect(page).not_to have_content I18n.t('posts.form.title')
        expect(page).not_to have_content I18n.t('posts.form.body')
        expect(page).not_to have_button I18n.t('posts.form.create')
      end
    end
  end
end
