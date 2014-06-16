class AddTypeToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :type, :string
  end
end
