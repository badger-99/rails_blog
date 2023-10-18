class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(author_id: params[:id]).order(created_at: :desc)
  end
end
