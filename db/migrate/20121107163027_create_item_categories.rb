class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string :name
      t.boolean :cookable
      t.binary :default_picture

      t.timestamps
    end
  end
end
