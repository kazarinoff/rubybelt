class Group < ActiveRecord::Base
  belongs_to :user
  has_many:members
  validates :name, :description, presence:true
  validates :description, length:{minimum:11}
  validates :name, length:{minimum:6}
end
