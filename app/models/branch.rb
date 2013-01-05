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
end
