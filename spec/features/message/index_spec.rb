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

  it 'sender tries to show all messages in conversation' do
    sign_in(sender)
    visit conversations_path
    click_on receiver.email
    expect(page).to have_content message.body
    expect(page).to have_content sender.email
    expect(page).to have_button I18n.t('messages.index.send')
  end

  it 'receiver tries to show all messages in conversation' do
    sign_in(receiver)
    visit conversations_path
    click_on sender.email
    expect(page).to have_content message.body
    expect(page).to have_content sender.email
    expect(page).to have_button I18n.t('messages.index.send')
  end
end
