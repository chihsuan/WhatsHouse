class AddUserIdToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :user_id, :integer
  end
end
