class CreateFilterDefinitions < ActiveRecord::Migration
  def change
    create_table :filter_definitions do |t|
      t.boolean :cookable
      t.boolean :cooked
      t.boolean :served
      t.text :tables

      t.timestamps
    end
  end
end
