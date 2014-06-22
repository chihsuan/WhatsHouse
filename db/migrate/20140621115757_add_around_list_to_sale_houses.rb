class AddAroundListToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :around_list, :string
  end
end
