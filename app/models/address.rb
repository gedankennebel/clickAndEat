class Address < ActiveRecord::Base
  attr_accessible :city, :number, :postcode, :street
end
