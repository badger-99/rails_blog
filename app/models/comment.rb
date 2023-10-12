class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_create :increment_post_comment_count

  private

  def increment_post_comment_count
    post.increment!(:comments_counter)
  end
end
