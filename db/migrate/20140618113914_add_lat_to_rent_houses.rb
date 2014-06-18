class AddLatToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :lat, :float
  end
end
