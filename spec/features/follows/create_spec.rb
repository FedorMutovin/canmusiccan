require 'rails_helper'

describe 'User can follow for other user', "
 In order to follow for other user
 As an authenticated user
 I'd like to be able to to follow for other user
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in(user) }

  it 'create follow', js: true do
    visit user_path(other_user)
    click_on I18n.t('follows.form.follow')
    expect(page).to have_content I18n.t('follows.form.unfollow')
  end
end
