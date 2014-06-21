class AddDistrictToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :district, :string
  end
end
