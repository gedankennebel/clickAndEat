class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.text :info_text
      t.string :name

      t.timestamps
    end
  end
end
