class AddLngToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :lng, :float
  end
end
