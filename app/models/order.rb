class Order < ActiveRecord::Base
  attr_accessible :timestamp
  has_many :order_itmes
  belongs_to :table
end
