class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :table_number
      t.timestamps

      #foreign key
      t.integer :branch_id
    end
  end
end
