class UserAccount < ActiveRecord::Base
  attr_accessible :email, :name, :password
  has_and_belongs_to_many :roles
  belongs_to :restaurant
end
