class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @users = User.select(:id, :name)
    @posts = Post.where(author_id: params[:user_id]).paginate(page: params[:page], per_page: 2).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @users = User.select(:id, :name)
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: params[:post_id]).order(created_at: :asc)
  end
end
