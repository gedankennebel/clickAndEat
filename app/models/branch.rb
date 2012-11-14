class Branch < ActiveRecord::Base
  attr_accessible :info_text, :opening_hours
  has_one :address
  has_many :tables
  belongs_to :restaurant
end
