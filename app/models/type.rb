class Type < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :restaurants

  validates_presence_of :name
  validates_uniqueness_of :name

  # create new type in database if not existing
  # return false if type is already existing
  # and true if this is a new type, after inserting successfully it into database
  def self.create_type type_name
    all_types = Type.all
    all_types.each do |type|
      if type.name.eql? type_name
        return
      end
    end
    Type.create!(name: type_name)
  end
end
