class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :email
      t.string :password_digest
      t.string :name

      t.timestamps
      #foreign key
      #t.integer :restaurant_id
    end
  end
end
