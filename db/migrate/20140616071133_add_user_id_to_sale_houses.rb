class AddUserIdToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :user_id, :integer
  end
end
