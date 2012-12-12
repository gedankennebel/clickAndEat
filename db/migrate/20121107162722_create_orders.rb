class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :closed, default: 0
      t.timestamps

      #foreign key
      t.integer :table_id

    end
  end
end
