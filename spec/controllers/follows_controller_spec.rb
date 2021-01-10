require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'POST #create' do
    context 'when user' do
      before { sign_in(user) }

      it 'create follow' do
        expect do
          post :create, params: { user_id: other_user.id }, format: :js
        end.to change(Follow, :count)
        expect(response.status).to eq 200
      end
    end

    context 'when unauthenticate_user' do
      it 'is not create track' do
        expect do
          post :create, params: { user_id: user.id }, format: :js
        end.not_to change(Follow, :count)
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when unauthenticate_user' do
      it 'is not destroy track' do
        expect do
          post :destroy, params: { user_id: user.id }, format: :js
        end.not_to change(user.all_following, :count)
        expect(response.status).to eq 401
      end
    end
  end
end
