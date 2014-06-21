class AddDistrictToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :district, :string
  end
end
