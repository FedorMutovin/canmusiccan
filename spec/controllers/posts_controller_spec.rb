require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:community) { create(:community, creator: user) }

  describe 'POST #create' do
    describe 'User' do
      context 'when user' do
        before { sign_in(user) }

        it 'create post' do
          expect do
            post :create, params: { user_id: user.id, post: attributes_for(:post) }, format: :js
          end.to change(Post, :count)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not create post' do
          expect do
            post :create, params: { user_id: user.id, post: attributes_for(:post) }, format: :js
          end.not_to change(Post, :count)
          expect(response.status).to eq 401
        end
      end
    end

    describe 'Community' do
      context 'when user' do
        before { sign_in(user) }

        it 'create post' do
          expect do
            post :create, params: { community_id: community.id, post: attributes_for(:post) }, format: :js
          end.to change(Post, :count)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not create post' do
          expect do
            post :create, params: { community_id: community.id, post: attributes_for(:post) }, format: :js
          end.not_to change(Post, :count)
          expect(response.status).to eq 401
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_post) { create(:post, postable: user) }

    describe 'User' do
      context 'when user' do
        before { sign_in(user) }

        it 'destroy post' do
          expect do
            delete :destroy, params: { id: user_post }, format: :js
          end.to change(Post, :count).by(-1)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not destroy post' do
          expect do
            delete :destroy, params: { id: user_post }, format: :js
          end.not_to change(Post, :count)
          expect(response.status).to eq 401
        end
      end
    end

    describe 'Community' do
      let!(:community_post) { create(:post, postable: community) }

      context 'when user' do
        before { sign_in(user) }

        it 'destroy post' do
          expect do
            delete :destroy, params: { id: community_post }, format: :js
          end.to change(Post, :count).by(-1)
          expect(response.status).to eq 200
        end
      end

      context 'when unauthenticate_user' do
        it 'is not destroy post' do
          expect do
            delete :destroy, params: { id: community_post }, format: :js
          end.not_to change(Post, :count)
          expect(response.status).to eq 401
        end
      end
    end
  end
end
