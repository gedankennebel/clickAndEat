class Table < ActiveRecord::Base
  attr_accessible :table_number, :branch_id
  belongs_to :branch
  has_many :orders

  validates_presence_of :branch, :table_number
  validates_associated :branch
  validates :table_number, numericality: {only_integer: true, greater_than: 0}
  validates_uniqueness_of :table_number, :scope => :branch_id

  def self.create_branch_tables tables_amount, branch_id
    last_table_id = Table.last.id
    Integer(tables_amount).times do
      Table.create!(table_number: (last_table_id+1), branch_id: branch_id)
      last_table_id += 1
    end
  end

  def self.get_table_numbers_as_array tables
    tables_array = Array.new
    tables.each do |table|
      tables_array << table.id
    end
    tables_array
  end
end
