class Blog < ApplicationRecord
  validates :title, presence:true, length: { maximum: 30 }
  validates :content, presence:true, length: { maximum: 300 }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
