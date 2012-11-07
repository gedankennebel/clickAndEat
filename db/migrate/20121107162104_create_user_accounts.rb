class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
