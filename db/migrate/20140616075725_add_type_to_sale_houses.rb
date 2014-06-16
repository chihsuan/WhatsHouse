class AddTypeToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :type, :string
  end
end
