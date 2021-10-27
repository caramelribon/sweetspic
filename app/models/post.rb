class Post < ApplicationRecord
  belongs_to :user
  
  validates :img, presence: true
  validates :genre, presence: true, length: { maximum: 50 }
  validates :location, presence: true, length: { maximum: 50 }
  validates :text, presence: false, length: { maximum: 100 }
  mount_uploader :img, ImgUploader
end
