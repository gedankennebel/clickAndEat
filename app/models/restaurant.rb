class Restaurant < ActiveRecord::Base
  attr_accessible :name, :picture
  has_many :branches
  has_many :types
  has_many :item_categories
end
