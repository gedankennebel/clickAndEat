class CreateJoinRestaurantsTypes < ActiveRecord::Migration
  def change
    create_table :restaurants_types, id:false do |t|
      t.references :restaurant, :null => false
      t.references :type, :null => false
    end
    add_index(:restaurants_types, [:restaurant_id, :type_id], :unique => true)
  end
end
