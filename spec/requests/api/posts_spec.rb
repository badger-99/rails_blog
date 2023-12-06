require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  describe 'GET /api/v1/posts/user/{user_id}' do
    path '/api/v1/posts/user/{user_id}' do
      get 'Retrieves all posts by a user' do
        tags 'Posts'
        produces 'application/vnd.api+json'
        parameter name: :user_id, in: :path, type: :string, description: 'User ID'

        response '200', 'successful' do
          schema type: :array,
                 items: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     title: { type: :string },
                     text: { type: :string },
                     created_at: { type: :string, format: 'date-time' },
                     updated_at: { type: :string, format: 'date-time' },
                     comments_counter: { type: :integer },
                     likes_counter: { type: :integer },
                     author_id: { type: :integer }
                   }
                 }

          let(:Authorization) { "Bearer #{user.authentication_token}" } # Include authentication token if needed
          let(:user_id) { user.id }

          run_test!
        end

        response '404', 'user not found' do
          let(:user_id) { 'nonexistent_id' }

          run_test!
        end
      end
    end
  end
  describe 'GET /api/v1/posts/{id}/comments' do
    # let(:post) { create(:post) } # Create a post for testing
    # let(:comments) { create_list(:comment, 3, post: post) } # Create comments for the post

    path '/api/v1/posts/{id}/comments' do
      get 'Retrieves comments for a post' do
        tags 'Comments'
        produces 'application/vnd.api+json'
        parameter name: :id, in: :path, type: :string, description: 'Post ID'

        response '200', 'successful' do
          schema type: :array,
                 items: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     text: { type: :string }
                   }
                 }
          let(:id) { post.id }
          run_test!
        end

        response '404', 'post not found' do
          let(:id) { 'nonexistent_id' }
          run_test!
        end
      end
    end
  end

  describe 'POST /api/v1/posts/{id}/comments' do
    let(:post) { create(:post) } # Create a post for testing
    let(:user) { create(:user) } # Create a user for testing

    path '/api/v1/posts/{id}/comments' do
      post 'Creates a new comment' do
        tags 'Comments'
        consumes 'application/vnd.api+json'
        parameter name: :id, in: :path, type: :string, description: 'Post ID'
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string }
          }
        }

        response '201', 'Comment Created' do
          run_test!
        end

        response '4xx', 'Bad Requesr' do
          schema type: :object, properties: {
            error: { type: :string },
            message: { type: :string }
          }
          run_test!
        end
      end
    end
  end
end
