require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:message) { create(:message, conversation: other_conversation, user: sender) }
  let(:other_conversation) { create(:conversation, sender: sender, receiver: receiver) }
  let(:receiver) { create(:user) }
  let(:sender) { create(:user) }

  it { belong_to :conversation }
  it { belong_to :user }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :conversation_id }
  it { is_expected.to validate_presence_of :user_id }

  context 'when time' do
    it 'show correct time' do
      expect(message.time).to eq message.created_at.strftime('%d/%m/%y at %l:%M %p')
    end
  end
end
