class RemoveTpyeToRentHouses < ActiveRecord::Migration
  def change
    remove_column :rent_houses, :tpye, :string
  end
end
