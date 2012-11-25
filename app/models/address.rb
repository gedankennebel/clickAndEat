class Address < ActiveRecord::Base
  attr_accessible :city, :number, :postcode, :street
  has_one :branch
  
  validates_presence_of :city, :street, :postcode, :number
end
