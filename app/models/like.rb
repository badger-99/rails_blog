class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_create :increment_post_like_count

  private

  def increment_post_like_count
    post.increment!(:likes_counter)
  end
end
