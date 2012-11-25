class OrderItem < ActiveRecord::Base
  attr_accessible :cooked, :quantity, :served
  belongs_to :order
  has_one :item

  validates_presence_of :cooked, :quantity, :served, :order
  validates :quantity, numericality: {only_integer: true, greater_than: 0} # quantity in positive integer

  validates_associated :order, :item
end
