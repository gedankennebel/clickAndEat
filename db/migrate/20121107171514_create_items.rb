class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.integer :cooktime
      t.binary :picture

      t.timestamps
    end
  end
end
