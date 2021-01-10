require 'rails_helper'

RSpec.describe SpotifyTracksController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #search_tracks' do
    context 'when user' do
      before { sign_in(user) }

      it 'search track' do
        get :search_tracks, params: { track_name: 'love' }, format: :js
        expect(response.status).to eq 200
      end
    end

    context 'when unauthenticate_user' do
      it 'is not search track' do
        get :search_tracks, params: { track_name: 'love' }, format: :js
        expect(response.status).to eq 401
      end
    end
  end

  describe 'POST #create' do
    let(:track_id) { '0q75NwOoFiARAVp4EXU4Bs' }

    context 'when user' do
      before { sign_in(user) }

      it 'create track' do
        expect do
          post :create, params: { track_id: track_id }, format: :js
        end.to change(user.spotify_tracks, :count)
        expect(response.status).to eq 200
      end
    end

    context 'when unauthenticate_user' do
      it 'is not create track' do
        expect do
          post :create, params: { track_id: track_id }, format: :js
        end.not_to change(user.spotify_tracks, :count)
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:spotify_track) { create(:spotify_track, user: user) }
    let(:other_user) { create(:user) }

    context 'when user' do
      before { sign_in(user) }

      it 'destroy track' do
        expect do
          post :destroy, params: { id: user.spotify_tracks.first }, format: :js
        end.to change(user.spotify_tracks, :count).by(-1)
        expect(response.status).to eq 200
      end
    end

    context 'when other_user' do
      before { sign_in(other_user) }

      it 'is not destroy track' do
        expect do
          post :destroy, params: { id: user.spotify_tracks.first }, format: :js
        end.not_to change(user.spotify_tracks, :count)
        expect(response.status).to eq 302
      end
    end

    context 'when unauthenticate_user' do
      it 'is not destroy track' do
        expect do
          post :destroy, params: { id: user.spotify_tracks.first }, format: :js
        end.not_to change(user.spotify_tracks, :count)
        expect(response.status).to eq 401
      end
    end
  end
end
