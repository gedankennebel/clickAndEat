class OrderItem < ActiveRecord::Base
  before_validation :default_values
  attr_accessible :cooked, :quantity, :served, :order, :item, :item_id
  belongs_to :order
  belongs_to :item
  #default_scope joins: :item

  validates_presence_of :order, :item
  validates :quantity, numericality: {only_integer: true, greater_than: 0} # quantity in positive integer
  validates :cooked, :inclusion => {:in => [true, false]}
  validates :served, :inclusion => {:in => [true, false]}
  validates_associated :order, :item

  def self.save_or_update_from_json(json)
    order_item = OrderItem.new.from_json(json)
    order_item_old = OrderItem.where(order_id: order_item.order_id, item_id: order_item.item_id).first
    if order_item_old
      order_item_old.quantity+=order_item.quantity
      order_item_old.save!
      order_item = order_item_old
    else
      order_item.save!
    end
    order_item
  end

  def update_from_json(json)
    self.from_json(json)
    if self.quantity == 0
      self.delete
    else
      self.save!
    end
  end

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
    from_hash(hash)
    self
  end

  def from_hash(hash)
    self.item_id= hash['item']['id']
    #self.order_id= hash['order_id']
    self.cooked= hash['cooked']
    self.quantity= hash['quantity']
    self.served= hash['served']
    self
  end

  private
  def default_values
    self.cooked||=0
    self.served||=0
    self.quantity||=1
  end

end
