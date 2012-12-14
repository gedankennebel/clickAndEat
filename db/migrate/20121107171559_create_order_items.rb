class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.boolean :cooked
      t.boolean :served
      t.integer :quantity

      #foreign key
      t.integer :item_id
      t.integer :order_id

      t.timestamps
    end
  end
end
