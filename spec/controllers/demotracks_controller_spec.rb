require 'rails_helper'

RSpec.describe DemotracksController, type: :controller do
  describe 'DELETE #destroy' do
    let(:current_user) { create(:user, :with_demotrack) }
    let(:other_user) { create(:user) }

    context 'when current_user' do
      before { sign_in(current_user) }

      it 'deletes the demotrack' do
        expect { delete :destroy, params: { id: current_user.demotracks.first }, format: :js }.to change(current_user.demotracks, :count).by(-1)
        expect(response).to render_template :destroy
      end
    end

    context 'when unauthenticated user' do
      it 'is not deletes the current user demotrack' do
        expect { delete :destroy, params: { id: current_user.demotracks.first }, format: :js }.not_to change(current_user.demotracks, :count)
        expect(response.status).to eq 401
      end
    end

    context 'when other user' do
      before { sign_in(other_user) }
      it 'is not deletes the current user demotrack' do
        expect { delete :destroy, params: { id: current_user.demotracks.first }, format: :js }.not_to change(current_user.demotracks, :count)
        expect(response.status).to eq 302
      end
    end
  end
end
