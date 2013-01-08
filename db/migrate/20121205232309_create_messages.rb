class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_text
      t.string :message_type

      t.timestamps
      t.integer :user_account_id
      t.integer :sender_account_id
    end
  end
end
