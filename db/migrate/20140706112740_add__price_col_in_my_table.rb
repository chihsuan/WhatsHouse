class AddPriceColInMyTable < ActiveRecord::Migration
  def change
  		 add_column :rent_houses, :price, :integer
  end
end
