class User < ActiveRecord::Base
  attr_accessible :email, :name, :role

  validates :role, presence: true
  validates :name,  presence: true, length: { maximum: 50 }

  #利用正则表达式来验证email的格式
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #这里要验证唯一性的时候，光是用uniqueness处理是不行的: a new-> b new -> a.save -> b.save
  #在这里从数据库层面来处理，加入唯一性索引
  validates :email, presence: true, format: { with: EMAIL_FORMAT }

end
