class AddAroundListToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :around_list, :string
  end
end
