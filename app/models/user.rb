class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :role, :password, :password_confirmation

  validates :name,  presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }

  validates :role, presence: true#这一块仍未修复, :exclusion => { :in => %w(0 1),
  # :message => "role must be 0 or 1(0 for teacher / 1 for student)" }  

  #利用正则表达式来验证email的格式
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #这里要验证唯一性的时候，光是用uniqueness处理是不行的: a new-> b new -> a.save -> b.save
  #在这里从数据库层面来处理，加入唯一性索引
  validates :email, presence: true, format: { with: EMAIL_FORMAT },uniqueness: { case_sensitive: false }

  #存入数据库之前做小写处理
  before_save { |user| user.email = email.downcase }

  has_secure_password  #现在rails中可以通过这一个方法做验证，先匹配用户输入，再匹配数据库中加密后的
end
