class OrderItem < ActiveRecord::Base
  attr_accessible :cooked, :quantity, :served
end
