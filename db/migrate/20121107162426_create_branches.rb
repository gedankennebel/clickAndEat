class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.text :info_text
      t.text :opening_hours

      t.timestamps

      #foreign keys
      t.integer :restaurant_id
      t.integer :address_id
    end
  end
end
