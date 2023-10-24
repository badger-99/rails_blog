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
      expect(response.body).to include('Posts')
    end
  end

  describe 'GET/show' do
    let(:user) { User.create(name: 'name', photo: 'www.selfie.pic', bio: 'bio') }
    let(:blog_post) { Post.create(title: 'title', text: 'this is a test', author_id: user.id) }

    it 'renders a succesfull result' do
      get "/users/#{user.id}/posts/#{blog_post.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get "/users/#{user.id}/posts/#{blog_post.id}"
      expect(response).to render_template(:show)
    end

    it 'renders the correct placeholder text' do
      get "/users/#{user.id}/posts/#{blog_post.id}"
      expect(response.body).to include('Article')
    end
  end
end
