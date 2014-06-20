class ChangeStoreTableName < ActiveRecord::Migration
  def change
  		rename_table :store_7_11s, :stores
  end
end
