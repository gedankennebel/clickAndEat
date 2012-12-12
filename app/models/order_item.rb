class OrderItem < ActiveRecord::Base
  attr_accessible :cooked, :quantity, :served, :order, :item, :item_id
  belongs_to :order
  belongs_to :item

  validates_presence_of :order
  validates :quantity, numericality: {only_integer: true, greater_than: 0} # quantity in positive integer
  validates :cooked, :inclusion => {:in => [true, false]}
  validates :served, :inclusion => {:in => [true, false]}
  validates_associated :order, :item

  def as_json(options = {})
    {
        id: id,
        order_id: order_id,
        cooked: cooked,
        quantity: quantity,
        served: served,
        item: item,
        links: {link: {rel: 'self', href: "/orders/#{order.id}/order_items/#{id}"}}
    }
  end

  def from_json(json, include_root=include_root_in_json)
    hash = ActiveSupport::JSON.decode(json)
    hash = hash.values.first if include_root
    self.item_id= hash['item']['id']
    self.order_id= hash['order_id']
    self.cooked= hash['cooked']
    self.quantity= hash['quantity']
    self.served= hash['served']
    self
  end

end
