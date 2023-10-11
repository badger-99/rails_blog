class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes
  has_many :comments
  before_create :increment_user_post_count

  scope :recent_comments, -> { includes(:comments).order(created_at: :desc).limit(5) }

  private

  def increment_user_post_count
    user.increment!(:posts_counter)
  end
end
