require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      get :index
    end

    it 'render index template' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:other_conversation) { create(:conversation, sender: sender, receiver: receiver) }

    context 'when authenticated user' do
      before { sign_in(sender) }

      it 'create message with conversation' do
        expect do
          post :create, params: { conversation_id: other_conversation, user_id: sender, body: '123' }, format: :js
        end.to change(other_conversation.messages, :count)
      end

      it 'create message without conversation' do
        expect do
          post :create, params: { sender_id: sender, receiver_id: receiver, body: '123' }, format: :js
        end.to change(Message, :count)
      end

      it 'is not create message with conversation' do
        expect do
          post :create, params: { conversation_id: other_conversation }, format: :js
        end.not_to change(Message, :count)
      end

      it 'is not create message without conversation' do
        expect do
          post :create, params: { receiver_id: receiver, body: '123' }, format: :js
        end.not_to change(Message, :count)
      end
    end

    context 'when unauthenticated user' do
      it 'create message with conversation' do
        expect do
          post :create, params: { conversation_id: other_conversation, user_id: sender, body: '123' }, format: :js
        end.not_to change(other_conversation.messages, :count)
        expect(response.status).to eq 401
      end

      it 'create message without conversation' do
        expect do
          post :create, params: { sender_id: sender, receiver_id: receiver, body: '123' }, format: :js
        end.not_to change(Message, :count)
        expect(response.status).to eq 401
      end
    end
  end
end
