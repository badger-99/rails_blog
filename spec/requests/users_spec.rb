require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET/index' do
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
      expect(response.body).to include('Users')
    end
  end

  describe 'GET/show' do
    subject { User.create(name: 'name', photo: 'www.selfie.pic', bio: 'bio') }

    it 'renders a succesfull result' do
      get "/users/#{subject.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get "/users/#{subject.id}"
      expect(response).to render_template(:show)
    end

    it 'renders the correct placeholder text' do
      get "/users/#{subject.id}"
      expect(response.body).to include('Profile')
    end
  end
end
