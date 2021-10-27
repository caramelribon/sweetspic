class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50}
    validates :email, presence: true, length: { maximum: 50}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
    validates :introduction, presence: false, length: { maximum: 100 }
    validates :avater, presence: false
    mount_uploader :avater, AvaterUploader
    has_secure_password
    
    has_many :posts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    def follow(other_user)
        unless self == other_user
          self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end

    def following?(other_user)
        self.followings.include?(other_user)
    end
end
