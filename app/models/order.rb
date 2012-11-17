class Order < ActiveRecord::Base
  has_many :order_itmes
  belongs_to :table
end
