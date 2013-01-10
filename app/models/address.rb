class Address < ActiveRecord::Base
  attr_accessible :city, :number, :postcode, :street
  has_one :branch

  validates_presence_of :city, :street, :postcode, :number

  def self.new_adress street, number, city, postcode
    Address.new(city: city, number: number, postcode: postcode, street: street)
  end
end
