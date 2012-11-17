class Type < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :restaurants

  validates :name, presence: true
  validates_associated :restaurants
end
