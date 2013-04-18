class User < ActiveRecord::Base 
  attr_accessible :email, :name, :role, :password, :password_confirmation
  has_many :tweets, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  


  validates :name,  presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { minimum: 5 }
  validates :role, presence: true#这一块仍未修复, :exclusion => { :in => %w(0 1),
  # :message => "role must be 0 or 1(0 for teacher / 1 for student)" }  

  #利用正则表达式来验证email的格式
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #这里要验证唯一性的时候，光是用uniqueness处理是不行的: a new-> b new -> a.save -> b.save
  #在这里从数据库层面来处理，加入唯一性索引
  validates :email, presence: true, format: { with: EMAIL_FORMAT },uniqueness: { case_sensitive: false }

  #存入数据库之前做小写处理
  before_save { |user| user.email = email.downcase }
  before_save :generate_auth_token

  has_secure_password  #现在rails中可以通过这一个方法做验证，先匹配用户输入，再匹配数据库中加密后的
  
  def generate_auth_token
      self.auth_token = SecureRandom.urlsafe_base64
  end

  def feed
    Tweet.from_users_followed_by(self)
  end

  def follow!(user)
    relationships.create!(followed_id: user.id)
  end

  def following?(user)
    relationships.find_by_followed_id(user.id)
  end

  def unfollow!(user)
    relationships.find_by_followed_id(user.id).destroy
  end
end
