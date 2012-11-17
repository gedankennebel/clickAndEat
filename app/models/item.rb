class Item < ActiveRecord::Base
  attr_accessible :cooktime, :name, :picture, :price
  belongs_to :item_category

  validates_presence_of :cooktime, :name, :price # validate as not null
  validates :cooktime, numericality: {only_integer: true, greater_than: 0} #cooktime in minutes and only positive integer values (without float)
  validates :price, numericality: {only_integer: false, greater_than: 0} # price musst be a positive float like 1.30 or 2.00
  validates :name, size: {minimum: 3} # a name must have at least 3 letters

  validates_associated :item_category # validate associated object
end
