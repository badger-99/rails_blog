class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to "/users/#{@user.id}/posts/#{@post.id}"
    else
      flash[:error] = 'There was an error posting the comment, please try again.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
