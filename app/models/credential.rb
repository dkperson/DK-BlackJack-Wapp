class Credential < ActiveRecord::Base 
  belongs_to :user

  validates :name, presence: true, length: {maximum: 30}, :exclusion => {
      :in => [ "dealer"],
      :message => "any user name but dealer"
  }
  validates :password, presence: true, length: {minimum: 6}
end
