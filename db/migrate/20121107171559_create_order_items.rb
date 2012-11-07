class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.boolean :cooked
      t.boolean :served
      t.integer :quantity

      t.timestamps
    end
  end
end
