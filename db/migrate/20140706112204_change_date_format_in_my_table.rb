class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
  		 remove_column :rent_houses, :price, :integer
  end
end
