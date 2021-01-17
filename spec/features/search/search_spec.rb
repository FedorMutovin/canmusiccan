require 'sphinx_helper'

describe 'User can search', "
  In order to search some information
  As an authenticate user
  I'd like to be able to use search
" do
  let!(:user) { create(:user) }
  let!(:community) { create(:community, creator: user) }

  before do
    sign_in(user)
    visit root_path
  end

  it 'search user', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      fill_in 'search_text', with: user.email
      click_on I18n.t('search.form.search')
      within('.search_results_block') do
        expect(page).to have_content(user.email)
      end
    end
  end

  it 'search community', sphinx: true, js: true do
    ThinkingSphinx::Test.run do
      fill_in 'search_text', with: community.name
      click_on I18n.t('search.form.search')
      within('.search_results_block') do
        expect(page).to have_content(community.name)
      end
    end
  end
end
