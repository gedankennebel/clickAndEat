class Branch < ActiveRecord::Base
  attr_accessible :opening_hours
  belongs_to :address
  has_many :tables
  belongs_to :restaurant
  has_many :user_accounts

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

  def self.create_new_branch restaurant, branch
    branch = Branch.new branch
    branch.restaurant = restaurant
    branch
  end
end
