class User < ActiveRecord::Base
  validates :name, uniqueness: true
  has_secure_password
  has_many :sneakers
end


# def name
#   @name
# end
#
# def name=(name)
#   @name = name
# end
