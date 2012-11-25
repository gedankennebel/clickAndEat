class AddDescriptionAndItemNumberToItem < ActiveRecord::Migration
  def change
    add_column :items, :description, :string
    add_column :items, :item_number, :integer
  end
end
