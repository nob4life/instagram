class Post < ApplicationRecord
  has_many :comments, dependent: :delete_all
  belongs_to :user
  has_many :likes, dependent: :delete_all
  
  validates :title, presence: true

  mount_uploader :image, ImageUploader
end