class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  scope :recent_users, -> { order(created_at: :desc).limit(3) }
end
