class UserAccount < ActiveRecord::Base
  attr_accessible :email, :name
  has_and_belongs_to_many :roles
  has_one :branch
end
