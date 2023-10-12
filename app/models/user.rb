class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  scope :recent_users, -> { order(created_at: :desc).limit(3) }
end
