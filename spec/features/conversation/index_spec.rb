require 'rails_helper'

describe 'User can show all of his conversations', "
 In order to have to be to show all my conversations
 As an authenticated user
 I'd like to be able to show all of my conversations
" do
  let(:sender) { create(:user) }
  let(:receiver) { create(:user) }
  let(:other_conversation) { create(:conversation, sender: sender, receiver: receiver) }
  let!(:message) { create(:message, conversation: other_conversation, user: sender, body: '123') }

  it 'tries to show all conversations as sender' do
    sign_in(sender)
    visit user_path(sender)
    click_on I18n.t('users.profile_buttons.messages')
    expect(page).to have_content receiver.email
    expect(page).not_to have_content sender.email
    expect(page).to have_content message.body
  end

  it 'tries to show all conversations as receiver' do
    sign_in(receiver)
    visit user_path(receiver)
    click_on I18n.t('users.profile_buttons.messages')
    expect(page).to have_content sender.email
    expect(page).not_to have_content receiver.email
    expect(page).to have_content message.body
  end

  it 'sender try show all conversations of receiver' do
    sign_in(sender)
    visit user_path(receiver)
    expect(page).not_to have_content I18n.t('users.profile_buttons.messages')
  end

  it 'receiver try show all conversations of sender' do
    sign_in(receiver)
    visit user_path(sender)
    expect(page).not_to have_content I18n.t('users.profile_buttons.messages')
  end
end
