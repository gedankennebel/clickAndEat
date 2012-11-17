class CreateJoinTypesRestaurants < ActiveRecord::Migration
  def change
    create_table :types_restaurants, id:false do |t|
    t.integer :type_id
    t.integer :restaurant_id
    end
  end    
end
