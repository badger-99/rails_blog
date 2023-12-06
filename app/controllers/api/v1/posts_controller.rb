class Api::V1::PostsController < JSONAPI::ResourceController
  before_action :set_json_api_content_type
  def user
    user = User.find(params[:user_id]) # Find the user by user_id parameter
    posts = user.posts # Get all posts by the user
    render json: posts, status: :ok
  end

  def comments
    post = Post.find(params[:id])
    comments = post.comments
    render json: comments, only: %i[id title text comments_counter author_id], status: :ok
  end

  def add_comment
    post = Post.find(params[:post_id])
    user = current_user

    comment = Comment.new(comment_params)
    comment.user_id = user.id
    comment.post_id = post.id

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_json_api_content_type
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def comment_params
    params.require(:comment).permit(:text) # Customize as per your Comment model attributes
  end
end
