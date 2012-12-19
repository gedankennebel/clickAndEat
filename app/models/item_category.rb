class ItemCategory < ActiveRecord::Base
  attr_accessible :cookable, :default_picture, :name
  belongs_to :restaurant
  has_many :items

  validates_presence_of :name
  validates :cookable, :inclusion => {:in => [true, false]}

  def as_json(options = {})
    {
        name: self.name,
        items: "/item_categories/#{id}/items"
    }
  end

end
