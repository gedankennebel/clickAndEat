class Branch < ActiveRecord::Base
  attr_accessible :info_text, :opening_hours
  belongs_to :address
  has_many :tables
  belongs_to :restaurant

  validates_presence_of :restaurant
  validates_associated :tables, :restaurant, :address
end
