class Course < ActiveRecord::Base
  attr_accessible :intro, :name
  belongs_to :user

  validates :user_id, presence: true
  validates :intro, presence: true
  validates :name, presence: true, length: { maximum: 50 }

end
