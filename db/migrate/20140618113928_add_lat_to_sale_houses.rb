class AddLatToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :lat, :float
  end
end
