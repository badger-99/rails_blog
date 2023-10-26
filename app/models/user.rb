class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.where(author_id: id).order(created_at: :desc).limit(3)
  end

  scope :recent_users, -> { order(created_at: :desc).limit(3) }
end
