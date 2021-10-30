class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_validation {email.downcase!}
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 50},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  has_secure_password
  validates :password, length: {minimum: 6, maximum: 25}
  before_destroy :protect_last_admin

  private
  def protect_last_admin
    throw :abort if self.admin && User.where(admin: true).count == 1
  end  
  
end