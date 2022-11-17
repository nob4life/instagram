class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, ImageUploader
  has_many :comments
  has_many :posts, dependent: :delete_all
  has_many :likes
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
                                  
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source:
  :followed
  
  has_many :followers, through: :passive_relationships, source:
  :follower

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                        WHERE follower_id = :id"
     User.where("id = :id OR id IN (#{following_ids})", id: id)
  end

end
