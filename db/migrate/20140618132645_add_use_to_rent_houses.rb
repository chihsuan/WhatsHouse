class AddUseToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :use, :string
  end
end
