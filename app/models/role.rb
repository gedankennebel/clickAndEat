class Role < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :user_accounts

  validates_associated :user_accounts
end
