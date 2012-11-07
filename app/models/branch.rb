class Branch < ActiveRecord::Base
  attr_accessible :info_text, :opening_hours
  has_one :address
end
