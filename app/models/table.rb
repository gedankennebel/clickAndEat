class Table < ActiveRecord::Base
  attr_accessible :table_number
  belongs_to :branch
  has_many :orders

  validates_presence_of :branch, :table_number
  validates_associated :branch
  validates :table_number, numericality: {only_integer: true, greater_than: 0}
  validates_uniqueness_of :table_number, :scope => :branch_id

  def as_json(options = {})
    {
        tables: tables
    }
  end
end
