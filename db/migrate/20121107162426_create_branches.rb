class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.text :info_text
      t.text :opening_hours

      t.timestamps
    end
  end
end
