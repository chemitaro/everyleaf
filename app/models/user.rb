class User < ApplicationRecord
  has_many :tasks
  before_validation {email.downcase!}
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 50},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  has_secure_password
  validates :password, length: {minimum: 6, maximum: 25}
  validates :user_id, presence: true
end