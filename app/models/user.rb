class User < ActiveRecord::Base
  has_many :credentials
  validates :name, presence: true, length: {maximum: 30}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

end
