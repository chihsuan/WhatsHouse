class AddDataToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :data, :string, default:'rent_houses'
  end
end
