class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50}
    validates :email, presence: true, length: { maximum: 50}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
    validates :introduction, presence: false, length: { maximum: 100 }
    validates :avater, presence: false
    mount_uploader :avater, AvaterUploader
    has_secure_password
    
    has_many :posts
end
