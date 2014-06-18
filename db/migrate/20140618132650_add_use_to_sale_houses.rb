class AddUseToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :use, :string
  end
end
