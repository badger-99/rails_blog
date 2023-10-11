class Like < ApplicationRecord
  belonge_to :user
  belonge_to :post
  before_create :increment_post_like_count

  private

  def increment_post_like_count
    post.increment!(:likes_counter)
  end
end
