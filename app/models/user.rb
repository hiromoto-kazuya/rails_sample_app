class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  before_validation { email.downcase! }

  has_secure_password
  validates :password_digest,presence: true, length: { minimum: 6 }

  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :icon, ImageUploader
end
