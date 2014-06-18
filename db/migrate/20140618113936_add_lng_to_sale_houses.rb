class AddLngToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :lng, :float
  end
end
