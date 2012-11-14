class OrderItem < ActiveRecord::Base
  attr_accessible :cooked, :quantity, :served
  belongs_to :order
  has_one :item
end
