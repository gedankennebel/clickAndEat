class ItemCategory < ActiveRecord::Base
  attr_accessible :cookable, :default_picture, :name
  belongs_to :restaurant
  has_one :item_category
  has_many :items

  validates_presence_of :name, :restaurant
  validates :cookable, :inclusion => { :in => [true, false] }
  validates_associated :restaurant, :item_category, :items # validate associated objects 
end
