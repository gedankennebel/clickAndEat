class Order < ActiveRecord::Base
  has_many :order_itmes
  belongs_to :table
 
  validates_associated :order_items, :tables
end
