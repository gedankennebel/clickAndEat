class Order < ActiveRecord::Base
  attr_accessible :closed, :table_id, :table
  has_many :order_items
  belongs_to :table

  validates :closed, :inclusion => {:in => [true, false]}
  validates_presence_of :table
  validates_associated :table

  def as_json(options = {})
    {
        table: table.table_number,
        order_items: order_items,
        links: {link: {rel: 'self', href: "/orders/#{id}"}}
        #links: {link: {rel:'self', href: orders_path(self)}}
    }
  end


end
