require 'rails_helper'

describe 'User can show his account page', "
 In order to show account information
 As an authenticated user
 I'd like to be able to show my account page
" do
  let!(:user) { create(:user) }

  describe 'Unauthenticated user' do
    it 'tries to show user account' do
      expect(page).not_to have_link(href: user_path(user))
    end
  end
end
