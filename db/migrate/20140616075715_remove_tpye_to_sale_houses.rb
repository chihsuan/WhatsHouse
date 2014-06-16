class RemoveTpyeToSaleHouses < ActiveRecord::Migration
  def change
    remove_column :sale_houses, :tpye, :string
  end
end
