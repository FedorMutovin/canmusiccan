require 'rails_helper'

describe 'User can sign out', "
 After the end of the session
 As an authenticated user
 I'd like to be able to sign out
" do
  let(:user) { create(:user) }

  it 'Authenticated user tries to sign out' do
    sign_in(user)
    click_on I18n.t('.shared.header.logout')
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
