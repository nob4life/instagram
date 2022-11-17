class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  validates :title, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end