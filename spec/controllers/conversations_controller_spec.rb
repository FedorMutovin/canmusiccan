require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before do
      sign_in(user)
      get :index
    end

    it 'render index template' do
      expect(response).to render_template :index
    end
  end
end
