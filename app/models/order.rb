class Order < ActiveRecord::Base
  attr_accessible :closed
  has_many :order_items
  belongs_to :table

  validates :closed, :inclusion => { :in => [true, false] }
  validates_presence_of :table
  validates_associated :order_items, :table
end
