class Api::V1::PostsController < ApplicationController
  def user
    user = User.find(params[:user_id]) # Find the user by user_id parameter
    posts = user.posts # Get all posts by the user
    render json: posts, status: :ok
  end
end
