require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    it 'returns 200 status code' do
      get :search, params: { search_text: 'some text' }, format: :js
      expect(response).to be_successful
    end

    it 'renders index template' do
      get :search, params: { search_text: 'some text' }, format: :js
      expect(response).to render_template :search
    end
  end
end
