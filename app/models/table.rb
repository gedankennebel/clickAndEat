class Table < ActiveRecord::Base
  attr_accessible :table_number
  belongs_to :branch
  has_many :orders
end
