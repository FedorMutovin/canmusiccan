require 'rails_helper'

RSpec.describe CommunitiesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:communities) { create_list(:community, 2, creator: user) }

    context 'when authenticated user' do
      before do
        sign_in(user)
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
    let(:community) { create(:community, creator: user) }

    context 'when authenticated user' do
      before do
        sign_in(user)
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
end
