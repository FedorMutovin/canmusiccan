module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in I18n.t('devise.sessions.new.password'), with: user.password
    within '.actions' do
      click_on I18n.t('devise.sessions.new.log_in')
    end
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end
end
