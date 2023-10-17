require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders a succesfull result' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'renders the correct placeholder text' do
      get '/users'
      expect(response.body).to include('Here is a list of all the users.')
    end
  end
end
