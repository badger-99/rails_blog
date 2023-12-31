class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = User.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id]).order(created_at: :desc)
  end
end
