require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:sender) { create(:user) }
  let(:receiver) { create(:user) }
  let(:other_conversation) { create(:conversation, sender: sender, receiver: receiver) }
  let!(:message) { create(:message, conversation: other_conversation, user: sender) }

  it { belong_to :sender }
  it { belong_to :receiver }
  it { is_expected.to have_many(:messages).dependent(:destroy) }
  it { is_expected.to validate_uniqueness_of(:sender_id).scoped_to(:receiver_id) }

  context 'when recipient(current_user)' do
    it 'return sender' do
      expect(other_conversation.recipient(receiver)).to eq sender
    end

    it 'return receiver' do
      expect(other_conversation.recipient(sender)).to eq receiver
    end
  end

  context 'when unread_message_count(current_user)' do
    it 'return 1 message' do
      expect(other_conversation.unread_message_count(receiver)).to eq 1
    end
  end
end
