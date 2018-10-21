class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  before_validation { email.downcase! }

  has_secure_password
  validates :password_digest,presence: true, length: { minimum: 6 }

  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follow_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followed_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :follow_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower

  def follow!(other_user)
    follow_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    follow_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    follow_relationships.find_by(followed_id: other_user.id).destroy
  end

  mount_uploader :icon, ImageUploader
end
