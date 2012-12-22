class Order < ActiveRecord::Base
  before_validation :default_values
  attr_accessible :closed, :table_id, :table
  has_many :order_items, autosave: true
  belongs_to :table
  #default_scope joins: [:order_items, :table] #eager loading

  validates :closed, :inclusion => {:in => [true, false]}
  validates_presence_of :table
  validates_associated :table

  def as_json(options = {})
    {
        id: id,
        table: table.table_number,
        closed: closed,
        order_items: order_items,
        created_at: created_at,
        links: {link: {rel: 'self', href: "/orders/#{id}"}}
        #links: {link: {rel:'self', href: orders_path(self)}}
    }
  end

  def from_json(json, include_root=include_root_in_json)
    hash = ActiveSupport::JSON.decode(json)
    hash = hash.values.first if include_root
    self.table_id = hash['table']
    self.closed = hash['closed']
    update_order_items(hash)
  end

  def broadcast(channel)
    puts self.to_json
    puts channel
    message = {:channel => channel, :data => self, :ext => {:auth_token => FAYE_TOKEN}}.to_json
    uri = URI.parse("http://localhost:9292/faye")
    puts Net::HTTP.post_form(uri, :message => message)
  end

  private
  def default_values
    self.closed||=0
  end

  def update_order_items(hash)
    order_item_ids = delete_not_included_order_items(hash)
    create_or_update_order_items(hash, order_item_ids)

  end

  def delete_not_included_order_items(hash)
    order_item_ids = []
    hash['order_items'].each do |order_item_hash|
      order_item_ids << order_item_hash['id']
    end
    #delete order_items that are not included
    self.order_items.each do |order_item|
      unless order_item_ids.include?(order_item.id)
        order_item.destroy
      end
    end
    order_item_ids
  end

  def create_or_update_order_items(hash, order_item_ids)
    hash['order_items'].each do |order_item_hash|
      order_item_ids << order_item_hash['id']
      order_item = get_order_item_by_id(self.order_items, order_item_hash['id'])
      if order_item
        #update old
        order_item.from_hash(order_item_hash)
      else
        #create new
        self.order_items << OrderItem.new.from_hash(order_item_hash)
      end
    end
  end

  def get_order_item_by_id(order_items, id)
    order_items.each do |order_item|
      if order_item.id == id
        return order_item
      end
    end
    nil
  end

end
