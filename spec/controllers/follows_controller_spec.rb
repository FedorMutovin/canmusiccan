require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:community) { create(:community, creator: user) }

  describe 'POST #create' do
    describe 'User' do
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
        it 'is not create follow' do
          expect do
            post :create, params: { user_id: user.id }, format: :js
          end.not_to change(Follow, :count)
          expect(response.status).to eq 401
        end
      end
    end

    describe 'Community' do
      context 'when user' do
        before { sign_in(user) }

        it 'create follow' do
          expect do
            post :create, params: { community_id: community.id }, format: :js
          end.to change(Follow, :count)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not create follow' do
          expect do
            post :create, params: { community_id: community.id }, format: :js
          end.not_to change(Follow, :count)
          expect(response.status).to eq 401
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_follow) { create(:follow, followable: other_user, follower: user) }
    let!(:community_follow) { create(:follow, followable: community, follower: user) }

    describe 'User' do
      context 'when user' do
        before { sign_in(user) }

        it 'destroy follow' do
          expect do
            post :destroy, params: { user_id: other_user.id }, format: :js
          end.to change(Follow, :count).by(-1)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not destroy follow' do
          expect do
            post :destroy, params: { user_id: user.id }, format: :js
          end.not_to change(Follow, :count)
          expect(response.status).to eq 401
        end
      end
    end

    describe 'Community' do
      context 'when user' do
        before { sign_in(user) }

        it 'destroy follow' do
          expect do
            post :destroy, params: { community_id: community.id }, format: :js
          end.to change(Follow, :count).by(-1)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not destroy follow' do
          expect do
            post :destroy, params: { community_id: community.id }, format: :js
          end.not_to change(Follow, :count)
          expect(response.status).to eq 401
        end
      end
    end
  end
end
