require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET/index' do
    subject { User.create(name: 'name', photo: 'www.selfie.pic', bio: 'bio') }

    it 'renders a succesfull result' do
      get "/users/#{subject.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get "/users/#{subject.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'renders the correct placeholder text' do
      get "/users/#{subject.id}/posts"
      expect(response.body).to include("These are all the posts by User #{subject.id}")
    end
  end
end
