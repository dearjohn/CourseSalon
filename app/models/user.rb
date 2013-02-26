class User < ActiveRecord::Base
  attr_accessible :email, :name, :role

  validates :role, presence: true
  validates :name,  presence: true, length: { maximum: 50 }

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_FORMAT }

end
