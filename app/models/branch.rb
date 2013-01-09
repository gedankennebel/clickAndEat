class Branch < ActiveRecord::Base
  attr_accessible :opening_hours
  belongs_to :address
  has_many :tables
  belongs_to :restaurant

  validates_presence_of :restaurant
  validates_associated :restaurant, :address

  def as_json(options = {})
    tables = []
    self.tables.each do |table|
      tables << table.table_number
    end

    {
        tables: tables
    }
  end

  def self.create_new_branch restaurant, branch, street, number, city, postcode
    branch = Branch.new branch
    branch.restaurant = restaurant
    branch.address = Address.create_new_adress street, number, city, postcode
    restaurant.branches << branch
    restaurant.save!
    branch
  end
end
