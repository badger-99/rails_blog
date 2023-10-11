class Comment < ApplicationRecord
  belonge_to :user
  belonge_to :post
  before_create :increment_post_comment_count

  private
  def increment_post_comment_count
    post.increment!(:comments_counter)
  end
end
