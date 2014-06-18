class AddDataToSaleHouses < ActiveRecord::Migration
  def change
    add_column :sale_houses, :data, :string, default:'sale_houses'
  end
end
