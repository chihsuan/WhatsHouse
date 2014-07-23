class AddIndexToTables < ActiveRecord::Migration
  def change
  	add_index :stores, :lat
  	add_index :stores, :lng
  	add_index :post_offices, :lat
  	add_index :post_offices, :lng
  	add_index :gas_stations, :lat
  	add_index :gas_stations, :lng
  	add_index :dinings, :lat
  	add_index :dinings, :lng
  	add_index :tainan_markets, :lat
  	add_index :tainan_markets, :lng
  	add_index :rent_houses, :address
  	add_index :rent_houses, :price
  	add_index :rent_houses, :people
  end
end
