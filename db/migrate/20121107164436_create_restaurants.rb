class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.binary :picture

      t.timestamps
    end
  end
end
