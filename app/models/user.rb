class User < ActiveRecord::Base
  has_secure_password
  has_many:groups
  has_many:members
  validates :first_name, :last_name, :email, presence:true
  validates :email, uniqueness:true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

end
