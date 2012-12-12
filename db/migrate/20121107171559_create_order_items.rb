class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.boolean :cooked, default: 0
      t.boolean :served, default: 0
      t.integer :quantity, default: 1

      #foreign key
      t.integer :item_id
      t.integer :order_id

      t.timestamps
    end
  end
end
