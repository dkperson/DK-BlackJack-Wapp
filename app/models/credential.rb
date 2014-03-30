class Credential < ActiveRecord::Base 
  belongs_to :user

  validates :name, presence: true, length: {maximum: 30}
  validates :password, presence: true, length: {minimum: 6}
end
