class PostsController < ApplicationController
  def new
    @post = Post.new
    @user = User.find(params[:user_id])
    @current_user = set_current_user
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(params[:user_id])

    if @post.save
      redirect_to "/users/#{@user.id}/posts/#{@post.id}"
    else
      flash[:error] = 'There was an error saving the post.'
      render 'new'
    end
  end

  def index
    @user = User.find(params[:user_id])
    @users = User.select(:id, :name)
    @posts = Post.where(author_id: params[:user_id]).paginate(page: params[:page], per_page: 2).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @users = User.select(:id, :name)
    @current_user = set_current_user
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: params[:post_id]).order(created_at: :asc)
    @comment = Comment.new
    @like = Like.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
