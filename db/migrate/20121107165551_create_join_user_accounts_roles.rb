class CreateJoinUserAccountsRoles < ActiveRecord::Migration
 def change
  create_table :user_accounts_roles, id:false do |t|
  t.integer :user_account_id
  t.integer :role_id
    end
  end
end
