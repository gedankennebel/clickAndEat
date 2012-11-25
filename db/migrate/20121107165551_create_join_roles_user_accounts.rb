class CreateJoinRolesUserAccounts < ActiveRecord::Migration
 def change
    create_table :roles_user_accounts, id:false do |t|
      t.references :role
      t.references :user_account
    end
    add_index(:roles_user_accounts, [:role_id, :user_account_id], :unique => true)
  end
end
