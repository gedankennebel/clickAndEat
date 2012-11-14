class Item < ActiveRecord::Base
  attr_accessible :cooktime, :name, :picture, :price
  belongs_to :item_category
end
