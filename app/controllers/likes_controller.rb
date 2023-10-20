class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = Like.new(comment_params)

    if @like.save
      redirect_to "/users/#{@user.id}/posts/#{@post.id}"
    else
      flash[:error] = 'There was an error saving the like, please try again.'
    end
  end

  private

  def comment_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
