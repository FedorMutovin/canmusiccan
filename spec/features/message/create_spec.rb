require 'rails_helper'

describe 'User can send messages', "
 In order to have to talk with other users
 As an authenticated user
 I'd like to be able to send messages
" do
  let(:sender) { create(:user) }
  let(:receiver) { create(:user) }
  let(:other_conversation) { create(:conversation, sender: sender, receiver: receiver) }
  let!(:message) { create(:message, conversation: other_conversation, user: sender, body: '123') }

  it 'sender tries to send message to receiver', js: true do
    sign_in(sender)
    visit user_path(receiver)
    click_on I18n.t('messages.form.send')
    expect(page).to have_content I18n.t('messages.form.new_message')
    fill_in :body, with: 'Hello'
    click_on I18n.t('messages.index.send')
    expect(page).to have_content 'Message is succesfull created'
    visit user_path(sender)
    click_on I18n.t('users.profile_buttons.messages')
    expect(page).to have_content receiver.email
    expect(page).not_to have_content sender.email
    expect(page).to have_content 'Hello'
    click_on receiver.email
    expect(page).to have_content 'Hello'
    expect(page).to have_content sender.email
    expect(page).to have_button I18n.t('messages.index.send')
  end

  it 'receiver tries to reply sender', js: true do
    sign_in(receiver)
    visit user_path(receiver)
    click_on I18n.t('users.profile_buttons.messages')
    visit conversations_path
    click_on sender.email
    fill_in :body, with: 'Hello'
    click_on I18n.t('messages.index.send')
    expect(page).to have_content 'Hello'
    expect(page).to have_content receiver.email
  end
end
