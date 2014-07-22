class AddIndexToRentHouses < ActiveRecord::Migration
  def change
  	add_index :rent_houses, :user_id
  end
end
