class Item < ActiveRecord::Base
  attr_accessible :cooktime, :name, :picture, :price, :description, :item_number
  belongs_to :item_category

  validates_presence_of :cooktime, :name, :price, :item_category # validate as not null
  validates :cooktime, numericality: {only_integer: true, greater_than: 0} #cooktime in minutes and only positive integer values (without float)
  validates :price, numericality: {only_integer: false, greater_than: 0} # price musst be a positive float like 1.30 or 2.00
  validates :item_number, numericality: {only_integer: true, greater_than: 0}
  validates :name, length: {minimum: 3} # a name must have at least 3 letters

  validates_associated :item_category # validate associated object

  def as_json(options = {})
    {
        id: self.id,
        itemNumber: self.item_number,
        name: self.name,
        description: self.description,
        price: self.price,
        picture: "/items/#{id}/picture",
    }
  end
end
