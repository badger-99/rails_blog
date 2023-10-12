class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes
  has_many :comments
  after_create :increment_user_post_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_user_post_count
    user.increment!(:posts_counter)
  end
end
