class Restaurant < ActiveRecord::Base
  attr_accessible :name, :picture
  has_many :branches
  has_many :item_categories
  has_many :user_accounts
  has_and_belongs_to_many :types
end
