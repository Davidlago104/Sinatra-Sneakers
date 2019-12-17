class User < ActiveRecord::Base
  has_secure_password

  validates :name, uniqueness: true
  has_many :sneakers
end
