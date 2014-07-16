class AddBrowseRateToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :browse_rate, :integer
  end
end
