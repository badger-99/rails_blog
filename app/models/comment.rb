class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post
  after_create :increment_post_comment_count

  private

  def increment_post_comment_count
    post.increment!(:comments_counter)
  end
end
