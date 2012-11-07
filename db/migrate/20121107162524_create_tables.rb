class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :table_number

      t.timestamps
    end
  end
end
