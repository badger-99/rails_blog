class Api::V1::PostsController < JSONAPI::ResourceController
  before_action :set_json_api_content_type
  def user
    user = User.find(params[:user_id]) # Find the user by user_id parameter
    posts = user.posts # Get all posts by the user
    render json: posts, status: :ok
  end

  def comments
    post = Post.find(params[:id]) # Find the post by post_id parameter
    comments = post.comments # Get all comments for the post
    render json: comments, status: :ok
  end
  
  private

  def set_json_api_content_type
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def comment_params
    params.require(:comment).permit(:text) # Customize as per your Comment model attributes
  end
end
