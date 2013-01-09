class Address < ActiveRecord::Base
  attr_accessible :city, :number, :postcode, :street
  has_one :branch

  validates_presence_of :city, :street, :postcode, :number

  def self.create_new_adress street, number, city, postcode
    Address.create!(city: city, number: number, postcode: postcode, street: street)
  end
end
