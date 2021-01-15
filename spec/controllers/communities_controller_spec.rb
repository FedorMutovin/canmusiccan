require 'rails_helper'

RSpec.describe CommunitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:community) { create(:community, creator: user) }

  describe 'GET #index' do
    let(:communities) { create_list(:community, 2, creator: user) }

    context 'when authenticated user' do
      before do
        login(user)
        get :index
      end

      it 'get all communities' do
        expect(assigns(:communities)).to match_array(communities)
      end

      it 'render index template' do
        expect(response).to render_template :index
      end
    end

    context 'when unauthenticated user' do
      before { get :index }

      it 'is not render index template' do
        expect(response.status).to eq 302
      end
    end
  end

  describe 'GET #show' do
    context 'when authenticated user' do
      before do
        login(user)
        get :show, params: { id: community }
      end

      it 'render show template' do
        expect(response).to render_template :show
      end
    end

    context 'when unauthenticated user' do
      before { get :show, params: { id: community } }

      it 'is not show community' do
        expect(response.status).to eq 302
      end
    end
  end

  describe 'GET #new' do
    context 'when authenticated user' do
      before do
        login(user)
        get :new
      end

      it 'assigns a new Community to @community' do
        expect(assigns(:community)).to be_a_new(Community)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'when unauthenticated user' do
      before { get :new }

      it 'is not show community' do
        expect(response.status).to eq 302
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before { login(user) }

      it 'saves a new community in the database' do
        expect do
          post :create, params: { community: attributes_for(:community), creator: user }
        end.to change(Community, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { community: attributes_for(:community), author: user }
        expect(response).to redirect_to assigns(:community)
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'does not save the community' do
        expect do
          post :create, params: { community: attributes_for(:community, :invalid) }
        end.not_to change(Community, :count)
      end

      it 're-renders new view' do
        post :create, params: { community: attributes_for(:community, :invalid) }
        expect(response).to render_template :new
      end
    end

    context 'without sign in' do
      it 'does not save the question' do
        expect do
          post :create, params: { community: attributes_for(:community), creator: user }
        end.not_to change(Community, :count)
      end

      it 'redirect to sign in' do
        post :create, params: { community: attributes_for(:community), creator: user }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'when authenticated user' do
      before do
        login(user)
        get :edit, params: { id: community }
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'when unauthenticated user' do
      before { get :edit, params: { id: community } }

      it 'is not show edit community' do
        expect(response.status).to eq 302
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new community in the database' do
        patch :update, params: { id: community, community: { name: 'new name', description: 'new description' } }
        community.reload
        expect(community.name).to eq 'new name'
        expect(community.description).to eq 'new description'
      end

      it 'renders update view' do
        patch :update, params: { id: community, community: attributes_for(:community) }
        expect(response).to redirect_to assigns(:community)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: community, community: attributes_for(:community, :invalid) } }

      it 'does not change answer attributes' do
        community.reload
        expect(community.name).to eq community.name
        expect(community.description).to eq community.description
      end

      it 'renders update view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:community) { create(:community, creator: user) }

    context 'with sign in' do
      before { login(user) }

      it 'deletes the community' do
        expect { delete :destroy, params: { id: community } }.to change(Community, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: community }
        expect(response).to redirect_to communities_path
      end
    end

    context 'without sign in' do
      it 'does not delete the community' do
        expect { delete :destroy, params: { id: community } }.not_to change(Community, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: community }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
