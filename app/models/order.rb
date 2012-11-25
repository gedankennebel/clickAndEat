class Order < ActiveRecord::Base
  has_many :order_itmes
  belongs_to :table
 
  validates_presence_of :table 
  validates_associated :order_items, :tables
end
