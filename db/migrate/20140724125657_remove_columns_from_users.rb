class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest
    remove_column :users, :remember_token
    remove_column :users, :password_reset_token
    remove_column :users, :password_reset_sent_at
    remove_column :users, :auth_token
  end
end
